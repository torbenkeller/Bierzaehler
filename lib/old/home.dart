//import 'package:bierzaehler/old/drinks_page.dart';
//import 'package:bierzaehler/old/home_change.dart';
//import 'package:bierzaehler/objects/drink.dart';
//import 'package:bierzaehler/objects/size.dart';
//import 'package:bierzaehler/objects/use.dart';
//import 'package:bierzaehler/old.objects/viewModels/home.dart';
//import 'package:bierzaehler/redux/app_state.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'package:redux/redux.dart';
//
//class HomePage extends StatelessWidget {
//  final TextEditingController _controllerName = TextEditingController();
//  final TextEditingController _controllerAlc = TextEditingController();
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//  @override
//  Widget build(BuildContext context) {
//
//    return StoreConnector<AppState, HomeViewModel>(
//        converter: (Store<AppState> store) {
//      return HomeViewModel.create(store);
//    }, builder: (BuildContext context, HomeViewModel viewModel) {
//      if (viewModel.state == DataState.LOADING) {
//        viewModel.getData();
//      }
//      return Scaffold(
//          appBar: AppBar(
//            title: Text("Bierzähler"),
//            actions: <Widget>[
//              IconButton(
//                icon: Icon(Icons.create),
//                onPressed: () {
//                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomeChange()));
//                },
//              )
//            ],
//          ),
//          body: DrinksPage(viewModel),
//          floatingActionButton: FloatingActionButton(
//              child: Icon(Icons.add),
//              onPressed: () {
//                showDialog(
//                    context: context,
//                    builder: (BuildContext context) {
//                      return new Dialog(
//                        child: Container(
//                            padding: EdgeInsets.all(16.0),
//                            child: Form(
//                                key: _formKey,
//                                child: SingleChildScrollView(
//                                    child: Column(
//                                      mainAxisSize: MainAxisSize.min,
//                                      crossAxisAlignment: CrossAxisAlignment.start,
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      children: <Widget>[
//                                        Text(
//                                          "Getränk hinzufügen",
//                                          style:
//                                          TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
//                                        ),
//                                        Padding(
//                                          padding: EdgeInsets.only(bottom: 16.0),
//                                        ),
//                                        TextFormField(
//                                          controller: _controllerName,
//                                          decoration: InputDecoration(
//                                              hintText: "Getränk", labelText: "Getränk"),
//                                          autofocus: true,
//                                          keyboardType: TextInputType.text,
//                                          validator: (String text) {
//                                            if (text.length > 32) {
//                                              return 'Zu Lang!';
//                                            }
//                                            if (text.length == 0) {
//                                              return 'Bitte gib hier das Getränk ein!';
//                                            }
//                                            return null;
//                                          },
//                                        ),
//                                        Padding(
//                                          padding: EdgeInsets.only(bottom: 16.0),
//                                        ),
//                                        TextFormField(
//                                          controller: _controllerAlc,
//                                          decoration: InputDecoration(
//                                              hintText: "Alkohol", labelText: "Alkohol in Vol. %"),
//                                          autofocus: false,
//                                          keyboardType:
//                                          TextInputType.numberWithOptions(decimal: true),
//                                          validator: (String text) {
//                                            if (text.length == 0) {
//                                              return 'Bitte gib hier den Alkoholgehalt ein!';
//                                            }
//                                            double alcohol = double.tryParse(text);
//                                            if(alcohol == null){
//                                              return 'Bitte benutze den Punkt anstatt des Kommas!';
//                                            }
//                                            if(alcohol < 0.0 || alcohol > 100.0){
//                                              return 'Prozent gehen nur von 0 bis 100!';
//                                            }
//                                            return null;
//                                          },
//                                        ),
//                                        Padding(
//                                          padding: EdgeInsets.only(bottom: 16.0),
//                                        ),
//                                        Row(
//                                          mainAxisSize: MainAxisSize.max,
//                                          mainAxisAlignment: MainAxisAlignment.end,
//                                          children: <Widget>[
//                                            FlatButton(
//                                              child: Text("ABBRECHEN"),
//                                              textColor: Theme.of(context).primaryColor,
//                                              onPressed: () => Navigator.of(context).pop(),
//                                            ),
//                                            RaisedButton(
//                                              child: Text("OK"),
//                                              color: Theme.of(context).primaryColor,
//                                              textColor: Colors.white,
//                                              onPressed: () {
//                                                if (_formKey.currentState.validate()) {
//                                                  List<Use> uses = new List<Use>();
//                                                  List<Size> sizes = new List<Size>();
//                                                  viewModel.addDrink(new Drink(
//                                                      _controllerName.text,
//                                                      double.parse(_controllerAlc.text),
//                                                      sizes,
//                                                      uses));
//                                                  _controllerAlc.text = "";
//                                                  _controllerName.text = "";
//                                                  Navigator.of(context).pop();
//                                                }
//                                              },
//                                            ),
//                                          ],
//                                        )
//                                      ],
//                                    )))),
//                      );
//                    });
//              }));
//    });
//  }
//}
