//import 'package:bierzaehler/old/drink_page.dart';
//import 'package:bierzaehler/old.objects/viewModels/home.dart';
//import 'package:bierzaehler/redux/app_state.dart';
//import 'package:flutter/material.dart';
//
//class DrinksPage extends StatelessWidget {
//  final HomeViewModel viewModel;
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
//  DrinksPage(this.viewModel);
//
//  @override
//  Widget build(BuildContext context) {
//    switch (viewModel.state) {
//      case DataState.LOADING:
//        return Center(
//          child: CircularProgressIndicator(),
//        );
//      case DataState.ERROR:
//        return Center(
//          child: Text("Es ist ein Fehler Aufgetreten!"),
//        );
//      case DataState.THERE:
//        if (viewModel.drinks.length == 0) {
//          return Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Text("Keine Getränke vohanden!"),
//                Text("Füge jetzt dein erstes Getränk hinzu!")
//              ],
//            ),
//          );
//        } else {
//          return ListView.builder(
//            itemCount: viewModel.drinks.length,
//            itemBuilder: (BuildContext context, int index) {
//              return Container(
//                padding: EdgeInsets.all(16.0),
//                child: Center(
//                  child: RawMaterialButton(
//                    onPressed: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (BuildContext context) =>
//                                  DrinkPage(index: index)));
//                    },
//                    fillColor: colors[index % 9],
//                    shape: CircleBorder(),
//                    child: Container(
//                      width: 96.0,
//                      height: 96.0,
//                      child: Center(
//                        child: Column(
//                            mainAxisSize: MainAxisSize.max,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: [
//                              Text(
//                                viewModel.drinks[index].name
//                                    .toString()
//                                    .toUpperCase(),
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.w700),
//                              ),
//                              Padding(
//                                padding: EdgeInsets.only(bottom: 8.0),
//                              ),
//                              Text(
//                                viewModel.drinks[index].alcohol.toString() + " Vol. %",
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.w700),
//                              ),
//                            ]),
//                      ),
//                    ),
//                  ),
//                ),
//              );
//            },
//          );
//        }
//        break;
//      default:
//        return Center(
//          child: Text("Es ist ein Fehler Aufgetreten!"),
//        );
//    }
//  }
//}
