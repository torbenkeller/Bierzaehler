import 'package:bierzaehler/application/beverages/beverages_list_change_notifier.dart';
import 'package:bierzaehler/application/category/category_list_change_notifier.dart';
import 'package:bierzaehler/domain/beverages/beverage.dart';
import 'package:bierzaehler/domain/beverages/i_beverage_repository.dart';
import 'package:bierzaehler/domain/category/category.dart';
import 'package:bierzaehler/injection.dart';
import 'package:bierzaehler/presentation/core/customizable_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateNewBeveragePage extends StatefulWidget {
  const CreateNewBeveragePage({Key key, this.toUpdate}) : super(key: key);

  final Beverage toUpdate;

  @override
  _CreateNewBeveragePageState createState() => _CreateNewBeveragePageState(toUpdate);
}

class _CreateNewBeveragePageState extends State<CreateNewBeveragePage> {
  _CreateNewBeveragePageState(this.toUpdate) : _shouldUpdateBeverage = toUpdate != null;
  final Beverage toUpdate;
  final bool _shouldUpdateBeverage;

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
    if (_shouldUpdateBeverage) {
      _nameController.text = toUpdate.name;
      _alcoholController.text = (toUpdate.alcohol * 100).toString();
      _selectedCategory = toUpdate.categoryID;
      _selectedColor = toUpdate.color.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final BeveragesListChangeNotifier bNotifier = Provider.of<BeveragesListChangeNotifier>(context);
    return Theme(
      data: ThemeData(primaryColor: Color(_selectedColor)),
      child: Scaffold(
        body: ChangeNotifierProvider<CategoryListChangeNotifier>(
          create: (BuildContext context) => getIt<CategoryListChangeNotifier>(),
          child: Consumer<CategoryListChangeNotifier>(
            builder: (_, CategoryListChangeNotifier cNotifier, __) => CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.check), onPressed: () => _submit(cNotifier, bNotifier))
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text((_shouldUpdateBeverage) ? 'Getränk ändern' : 'Neues Getränk'),
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
                              validator: (String value) =>
                                  (value.isEmpty) ? 'Bitte gib einen Namen ein' : null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 72, right: 32),
                            child: TextFormField(
                              controller: _alcoholController,
                              keyboardType: const TextInputType.numberWithOptions(),
                              decoration: const InputDecoration(
                                  alignLabelWithHint: true, labelText: 'Alkoholgehalt in % vol.'),
                              validator: (String value) {
                                try {
                                  final String valueFormatted = value.replaceAll(',', '.');
                                  final double alcohol = double.parse(valueFormatted);
                                  if (alcohol < 0) {
                                    return 'Der Alkoholgehalt darf'
                                        ' nicht negativ sein';
                                  }
                                  if (alcohol > 100) {
                                    return 'Der Alkoholgehalt muss'
                                        ' kleiner 100 sein';
                                  }
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
                      child: Text('Farbe', style: Theme.of(context).textTheme.subhead),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 72, right: 32, top: 16),
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
                                          right: (color.value != _colors[_colors.length - 1].value)
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
                      child: Text('Kategorie', style: Theme.of(context).textTheme.subhead),
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
                                      alignLabelWithHint: true, labelText: 'Neue Kategorie'),
                                  validator: (String value) =>
                                      (value.isEmpty) ? 'Bitte gib eine Kategorie ein' : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ..._buildCategoriesList(cNotifier),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCategoriesList(CategoryListChangeNotifier notifier) {
    if (notifier.categoriesList == null) return <Widget>[Container()];
    return <Widget>[
      for (Category category in notifier.categoriesList)
        InkWell(
          onTap: () => setState(() => _selectedCategory = category.id),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 72,
                height: 48,
                child: Radio<int>(
                  value: category.id,
                  groupValue: _selectedCategory,
                  onChanged: _changeCategory,
                  activeColor: Color(_selectedColor),
                ),
              ),
              Expanded(child: Text(category.name)),
            ],
          ),
        ),
    ];
  }

  Future<void> _submit(
      CategoryListChangeNotifier cNotifier, BeveragesListChangeNotifier bNotifier) async {
    if (_beverageFormKey.currentState.validate()) {
      String categoryName;
      if (_selectedCategory == 0) {
        if (!_categoryFormKey.currentState.validate()) {
          return;
        }
        categoryName = _categoryController.text;
      } else {
        if (cNotifier.categoriesList != null) {
          categoryName =
              cNotifier.categoriesList.lastWhere((Category c) => c.id == _selectedCategory).name;
        }
      }
      final String alcoholText = _alcoholController.text.replaceAll(',', '.');
      final double alcohol = (double.parse(alcoholText) / 100.0).abs();
      if (_shouldUpdateBeverage) {
        if (await bNotifier.updateBeverage(UpdateBeverageParams(
          old: toUpdate,
          newColor: _selectedColor,
          newAlcohol: alcohol,
          newName: _nameController.text,
          newCategoryName: categoryName,
        ))) {
          Navigator.of(context).pop();
        } else {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Ups!'),
                content: const Text('Bei dem Aändern des Getränks ist ein'
                    ' Fehler aufgetreten.\nBitte überprüfe'
                    ' deine Eingaben.'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        if (await bNotifier.createNewBeverage(CreateBeverageParams(
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
                content: const Text('Bei der Erstellung des Getränks ist ein'
                    ' Fehler aufgetreten.\nBitte überprüfe'
                    ' deine Eingaben und ob es schon ein'
                    ' Getränk mit dem selben Namen gibt.'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }
}
