//import 'package:bierzaehler/old.objects/viewModels/home.dart';
//import 'package:bierzaehler/redux/app_state.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'package:redux/redux.dart';
//
//class HomeChange extends StatelessWidget {
//  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//  final TextEditingController _controllerAlc = new TextEditingController();
//  final TextEditingController _controllerName = new TextEditingController();
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
//  Widget dialog(
//      {@required BuildContext context,
//      @required HomeViewModel viewModel,
//      @required int index}) {
//    _controllerName.text = viewModel.drinks[index].name.toString();
//    _controllerAlc.text = viewModel.drinks[index].alcohol.toString();
//
//    return new Dialog(
//      child: Container(
//          padding: EdgeInsets.all(16.0),
//          child: Form(
//              key: _formKey,
//              child: SingleChildScrollView(
//                  child: Column(
//                mainAxisSize: MainAxisSize.min,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Text(
//                    "Getränk bearbeiten",
//                    style:
//                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(bottom: 16.0),
//                  ),
//                  TextFormField(
//                    controller: _controllerName,
//                    decoration: InputDecoration(
//                        hintText: "Getränk", labelText: "Getränk"),
//                    autofocus: true,
//                    keyboardType: TextInputType.text,
//                    validator: (String text) {
//                      if (text.length > 32) {
//                        return 'Zu Lang!';
//                      }
//                      if (text.length == 0) {
//                        return 'Bitte gib hier das Getränk ein!';
//                      }
//                      return null;
//                    },
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(bottom: 16.0),
//                  ),
//                  TextFormField(
//                    controller: _controllerAlc,
//                    decoration: InputDecoration(
//                        hintText: "Alkohol", labelText: "Alkohol in Vol. %"),
//                    autofocus: false,
//                    keyboardType:
//                        TextInputType.numberWithOptions(decimal: true),
//                    validator: (String text) {
//                      if (text.length == 0) {
//                        return 'Bitte gib hier den Alkoholgehalt ein!';
//                      }
//                      double alcohol = double.tryParse(text);
//                      if(alcohol == null){
//                        return 'Bitte benutze den Punkt anstatt des Kommas!';
//                      }
//                      if(alcohol < 0.0 || alcohol > 100.0){
//                        return 'Prozent gehen nur von 0 bis 100!';
//                      }
//                      return null;
//                    },
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(bottom: 16.0),
//                  ),
//                  Row(
//                    mainAxisSize: MainAxisSize.max,
//                    mainAxisAlignment: MainAxisAlignment.end,
//                    children: <Widget>[
//                      FlatButton(
//                        child: Text("ABBRECHEN"),
//                        textColor: Theme.of(context).primaryColor,
//                        onPressed: () => Navigator.of(context).pop(),
//                      ),
//                      RaisedButton(
//                        child: Text("SPEICHERN"),
//                        color: Theme.of(context).primaryColor,
//                        textColor: Colors.white,
//                        onPressed: () {
//                          if (_formKey.currentState.validate()) {
//                            viewModel.editDrink(
//                                index,
//                                _controllerName.text.toString(),
//                                double.parse(_controllerAlc.text.toString()));
//                            _controllerAlc.text = "";
//                            _controllerName.text = "";
//                            Navigator.of(context).pop();
//                          }
//                        },
//                      ),
//                    ],
//                  )
//                ],
//              )))),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return StoreConnector<AppState, HomeViewModel>(
//        converter: (Store<AppState> store) {
//      return HomeViewModel.create(store);
//    }, builder: (BuildContext context, HomeViewModel viewModel) {
//      if (viewModel.drinks.length == 0) {
//        return Scaffold(
//            appBar: AppBar(
//              title: Text("Bierzähler"),
//              leading: IconButton(
//                  icon: Icon(Icons.close),
//                  onPressed: () => Navigator.of(context).pop()),
//            ),
//            body: Center(
//              child: Text("Füge zuerst Getränke hinzu!"),
//            ));
//      }
//
//      return Scaffold(
//        appBar: AppBar(
//          title: Text("Getränke bearbeiten"),
//          leading: IconButton(
//              icon: Icon(Icons.close),
//              onPressed: () => Navigator.of(context).pop()),
//        ),
//        body: ListView.builder(
//            itemCount: viewModel.drinks.length,
//            itemBuilder: (BuildContext context, int index) {
//              return Container(
//                padding: EdgeInsets.all(16.0),
//                child: Center(
//                  child: Stack(
//                    alignment: Alignment.topRight,
//                    children: <Widget>[
//                      SizedBox(
//                        width: 96.0,
//                        height: 96.0,
//                        child: RawMaterialButton(
//                          onPressed: () {
//                            showDialog(
//                                context: context,
//                                builder: (BuildContext context) => dialog(
//                                    viewModel: viewModel,
//                                    context: context,
//                                    index: index));
//                          },
//                          fillColor: colors[index % 9],
//                          shape: CircleBorder(),
//                          child: Container(
//                            width: 96.0,
//                            height: 96.0,
//                            child: Center(
//                              child: Column(
//                                  mainAxisSize: MainAxisSize.max,
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: [
//                                    Text(
//                                      viewModel.drinks[index].name
//                                          .toString()
//                                          .toUpperCase(),
//                                      style: TextStyle(
//                                          color: Colors.white,
//                                          fontWeight: FontWeight.w700),
//                                    ),
//                                    Padding(
//                                      padding: EdgeInsets.only(bottom: 8.0),
//                                    ),
//                                    Text(
//                                      viewModel.drinks[index].alcohol
//                                              .toString() +
//                                          " Vol. %",
//                                      style: TextStyle(
//                                          color: Colors.white,
//                                          fontWeight: FontWeight.w700),
//                                    ),
//                                  ]),
//                            ),
//                          ),
//                        ),
//                      ),
//                      Container(
//                        height: 36.0,
//                        width: 36.0,
//                        child: RawMaterialButton(
//                          fillColor: Colors.white,
//                          child: Icon(Icons.delete),
//                          shape: CircleBorder(),
//                          onPressed: () {
//                            showDialog(
//                                context: context,
//                                builder: (BuildContext context) {
//                                  return SimpleDialog(
//                                    title: Text("Getränk Löschen"),
//                                    contentPadding: EdgeInsets.only(
//                                        left: 24.0,
//                                        right: 24.0,
//                                        top: 16.0,
//                                        bottom: 16.0),
//                                    children: <Widget>[
//                                      Text(
//                                          'Möchtest du das Getränk "${viewModel.drinks[index].name.toString()}" wirklich unwiderruflich löschen?'),
//                                      Padding(
//                                        padding: EdgeInsets.only(bottom: 16.0),
//                                      ),
//                                      Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.end,
//                                        children: <Widget>[
//                                          FlatButton(
//                                            child: Text("ABBRECHEN"),
//                                            onPressed: () =>
//                                                Navigator.of(context).pop(),
//                                            textColor: Colors.red,
//                                          ),
//                                          RaisedButton(
//                                            child: Text("LÖSCHEN"),
//                                            onPressed: () {
//                                              viewModel.deleteDrink(index);
//                                              Navigator.of(context).pop();
//                                            },
//                                            color: Colors.red,
//                                            textColor: Colors.white,
//                                          ),
//                                        ],
//                                      )
//                                    ],
//                                  );
//                                });
//                          },
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              );
//            }),
//      );
//    });
//  }
//}
