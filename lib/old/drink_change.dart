//import 'package:bierzaehler/objects/size.dart';
//import 'package:bierzaehler/old.objects/viewModels/drink.dart';
//import 'package:bierzaehler/redux/app_state.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'package:redux/redux.dart';
//
//class DrinkChange extends StatelessWidget {
//  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//  final TextEditingController _controller = new TextEditingController();
//  final int drinkIndex;
//
//  static const List<Color> colors = [
//    const Color(0xff7b1fa2),
//    const Color(0xff0091ea),
//    const Color(0xfff50057),
//    const Color(0xff388e3c),
//    const Color(0xffff6f00),
//    const Color(0xff6d4c41),
//    const Color(0xff00838f),
//    const Color(0xff1a237e),
//    const Color(0xff558b2f),
//  ];
//
//  DrinkChange({@required this.drinkIndex});
//
//  Widget dialog(
//      {@required BuildContext context,
//      @required DrinkViewModel viewModel,
//      @required int index}) {
//    _controller.text = viewModel.drink.sizes[index].value.toString();
//
//    return new Dialog(
//      child: Container(
//          padding: EdgeInsets.all(16.0),
//          child: SingleChildScrollView(
//              child: Column(
//            mainAxisSize: MainAxisSize.min,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                "Glas bearbeiten",
//                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
//              ),
//              Padding(
//                padding: EdgeInsets.only(bottom: 16.0),
//              ),
//              Form(
//                key: _formKey,
//                child: TextFormField(
//                  controller: _controller,
//                  decoration: InputDecoration(
//                    hintText: "Größe in Litern",
//                    labelText: "Größe",
//                  ),
//                  autofocus: true,
//                  keyboardType: TextInputType.numberWithOptions(
//                    decimal: true,
//                  ),
//                  validator: (input) {
//                    if (input.length == 0)
//                      return 'Bitte gib hier die Größe ein!';
//                    return double.tryParse(input) == null
//                        ? 'Bitte benutze den Punkt anstatt des Kommas!'
//                        : null;
//                  },
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.only(bottom: 16.0),
//              ),
//              Row(
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: <Widget>[
//                  FlatButton(
//                    child: Text("ABBRECHEN"),
//                    textColor: Theme.of(context).primaryColor,
//                    onPressed: () => Navigator.of(context).pop(),
//                  ),
//                  RaisedButton(
//                    child: Text("SPEICHERN"),
//                    color: Theme.of(context).primaryColor,
//                    textColor: Colors.white,
//                    onPressed: () {
//                      if (_formKey.currentState.validate()) {
//                        viewModel.renameSize(
//                            index, new Size(double.parse(_controller.text)));
//                        _controller.text = "";
//                        Navigator.of(context).pop();
//                      }
//                    },
//                  ),
//                ],
//              )
//            ],
//          ))),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ThemeData t = Theme.of(context);
//
//    return Theme(
//        data: t.copyWith(
//            primaryColor: colors[drinkIndex % colors.length],
//            accentColor: colors[(drinkIndex + 1) % colors.length]),
//        child: StoreConnector<AppState, DrinkViewModel>(
//            converter: (Store<AppState> store) {
//          return DrinkViewModel.create(store, drinkIndex);
//        }, builder: (BuildContext context, DrinkViewModel viewModel) {
//          if (viewModel.drink.sizes.length == 0) {
//            return Scaffold(
//              appBar: AppBar(
//                title: Text(viewModel.drink.name.toString() + " bearbeiten"),
//                leading: IconButton(
//                    icon: Icon(Icons.close),
//                    onPressed: () => Navigator.of(context).pop()),
//              ),
//              body: Center(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Text("Keine Gläser vohanden!"),
//                    Text("Füge jetzt dein erstes Glas hinzu!")
//                  ],
//                ),
//              ),
//            );
//          }
//
//          return Scaffold(
//            appBar: AppBar(
//              title: Text(viewModel.drink.name.toString() + " bearbeiten"),
//              leading: IconButton(
//                  icon: Icon(Icons.close),
//                  onPressed: () => Navigator.of(context).pop()),
//            ),
//            body: ListView.builder(
//                itemCount: viewModel.drink.sizes.length,
//                itemBuilder: (BuildContext context, int index) {
//                  return Container(
//                    padding: EdgeInsets.all(16.0),
//                    child: Center(
//                      child: Stack(
//                        alignment: Alignment.topRight,
//                        children: <Widget>[
//                          SizedBox(
//                            width: 96.0,
//                            height: 96.0,
//                            child: RawMaterialButton(
//                              onPressed: () {
//                                showDialog(
//                                    context: context,
//                                    builder: (BuildContext context) => dialog(
//                                        viewModel: viewModel,
//                                        context: context,
//                                        index: index));
//                              },
//                              fillColor: colors[index % 9],
//                              shape: CircleBorder(),
//                              child: Container(
//                                width: 96.0,
//                                height: 96.0,
//                                child: Center(
//                                  child: Text(
//                                    viewModel.drink.sizes[index].value
//                                        .toString()
//                                        .toUpperCase() + "l",
//                                    style: TextStyle(
//                                        color: Colors.white,
//                                        fontWeight: FontWeight.w700),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                          Container(
//                            height: 36.0,
//                            width: 36.0,
//                            child: RawMaterialButton(
//                              fillColor: Colors.white,
//                              child: Icon(Icons.delete),
//                              shape: CircleBorder(),
//                              onPressed: () {
//                                showDialog(
//                                    context: context,
//                                    builder: (BuildContext context) {
//                                      return SimpleDialog(
//                                        title: Text("Glas Löschen"),
//                                        contentPadding: EdgeInsets.only(
//                                            left: 24.0,
//                                            right: 24.0,
//                                            top: 16.0,
//                                            bottom: 16.0),
//                                        children: <Widget>[
//                                          Text(
//                                              'Möchtest du das Glas "${viewModel.drink.sizes[index].value.toString()}l" wirklich unwiderruflich löschen?'),
//                                          Padding(
//                                            padding:
//                                                EdgeInsets.only(bottom: 16.0),
//                                          ),
//                                          Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.end,
//                                            children: <Widget>[
//                                              FlatButton(
//                                                child: Text("ABBRECHEN"),
//                                                onPressed: () =>
//                                                    Navigator.of(context).pop(),
//                                                textColor: Colors.red,
//                                              ),
//                                              RaisedButton(
//                                                child: Text("LÖSCHEN"),
//                                                onPressed: () {
//                                                  viewModel.deleteSize(index);
//                                                  Navigator.of(context).pop();
//                                                },
//                                                color: Colors.red,
//                                                textColor: Colors.white,
//                                              ),
//                                            ],
//                                          )
//                                        ],
//                                      );
//                                    });
//                              },
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  );
//                }),
//          );
//        }));
//  }
//}
