import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/presentation/manager/beverages_list_change_notifier.dart';
import 'package:bierzaehler/features/beverage/presentation/widgets/customizable_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateNewBeveragePage extends StatefulWidget {
  @override
  _CreateNewBeveragePageState createState() => _CreateNewBeveragePageState();
}

class _CreateNewBeveragePageState extends State<CreateNewBeveragePage> {
  TextEditingController _nameController;
  TextEditingController _alcoholController;
  TextEditingController _categoryController;

  int _selectedColor;
  int _selectedCategory;

  GlobalKey<FormState> _beverageFormKey;
  GlobalKey<FormState> _categoryFormKey;

  static const List<Color> _colors = <Color>[
    Color(0xff7b1fa2),
    Color(0xff0091ea),
    Color(0xfff50057),
    Color(0xff388e3c),
    Color(0xffff6f00),
    Color(0xff6d4c41),
    Color(0xff00838f),
    Color(0xff1a237e),
    Color(0xff558b2f),
  ];

  void _changeColor(int value) {
    setState(() {
      _selectedColor = value;
    });
  }

  void _changeCategory(int value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _alcoholController = TextEditingController();
    _categoryController = TextEditingController();
    _selectedColor = _colors[0].value;
    _selectedCategory = 0;
    _beverageFormKey = GlobalKey<FormState>();
    _categoryFormKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final BeveragesListChangeNotifier notifier =
        Provider.of<BeveragesListChangeNotifier>(context);
    return Theme(
      data: ThemeData(primaryColor: Color(_selectedColor)),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () async {
                    if (_beverageFormKey.currentState.validate()) {
                      String categoryName;
                      if (_selectedCategory == 0) {
                        if (!_categoryFormKey.currentState.validate()) return;
                        categoryName = _categoryController.text;
                      } else {
                        //TODO: make category selectable
                        // categoryName = selectedCategoryName
                      }

                      final double alcohol =
                          int.parse(_alcoholController.text) / 1000.0;
                      if (await notifier.createNewBeverage(CreateBeverageParams(
                        color: _selectedColor,
                        alcohol: alcohol,
                        name: _nameController.text,
                        categoryName: categoryName,
                      ))) {
                        Navigator.of(context).pop();
                      } else {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text('Ups!'),
                              content: const Text(
                                  'Bei der Erstellung des Getränks ist ein'
                                  ' Fehler aufgetreten.\nBitte überprüfe,'
                                  ' ob es schon ein Getränk mit dem selben'
                                  ' Namen gibt.'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext)
                                        .pop(); // Dismiss alert dialog
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                )
              ],
              flexibleSpace: const FlexibleSpaceBar(
                title: Text('Neues Getränk'),
                //TODO: replace placeholder
                background: Placeholder(),
              ),
              expandedHeight: 230,
            ),
            SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                Form(
                  key: _beverageFormKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 72, right: 32),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                              alignLabelWithHint: true, labelText: 'Name'),
                          validator: (String value) => (value.isEmpty)
                              ? 'Bitte gib einen Namen ein'
                              : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 72, right: 32),
                        child: TextFormField(
                          controller: _alcoholController,
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              labelText: 'Alkoholgehalt in ml'),
                          validator: (String value) {
                            try {
                              int.parse(value);
                              return null;
                            } catch (e) {
                              return 'Bitte gib eine ganze Zahl ein';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 72, right: 32, top: 16),
                  child:
                      Text('Farbe', style: Theme.of(context).textTheme.subhead),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 72, right: 32, top: 16),
                    child: Container(
                      height: 39,
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate(
                              <Widget>[
                                for (Color color in _colors)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: (color.value !=
                                              _colors[_colors.length - 1].value)
                                          ? 8.0
                                          : 0.0,
                                    ),
                                    child: ColorRadioButton(
                                      colorNum: color.value,
                                      selectedColorNum: _selectedColor,
                                      onChanged: _changeColor,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 72, right: 32, top: 16),
                  child: Text('Kategorie',
                      style: Theme.of(context).textTheme.subhead),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () => _changeCategory(0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 72,
                          child: Radio<int>(
                            value: 0,
                            groupValue: _selectedCategory,
                            onChanged: _changeCategory,
                            activeColor: Color(_selectedColor),
                          ),
                        ),
                        Expanded(
                          child: Form(
                            key: _categoryFormKey,
                            child: TextFormField(
                              controller: _categoryController,
                              onTap: () => _changeCategory(0),
                              decoration: const InputDecoration(
                                  alignLabelWithHint: true,
                                  labelText: 'Neue Kategorie'),
                              validator: (String value) => (value.isEmpty)
                                  ? 'Bitte gib eine Kategorie ein'
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
