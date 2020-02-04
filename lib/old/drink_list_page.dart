//import 'package:bierzaehler/old.objects/viewModels/drink.dart';
//import 'package:flutter/material.dart';
//
//class DrinkListPage extends StatelessWidget {
//  final DrinkViewModel viewModel;
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
//  DrinkListPage({@required this.viewModel, @required this.drinkIndex});
//
//  @override
//  Widget build(BuildContext context) {
//    if (viewModel.drink.sizes.length == 0) {
//      return Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Text("Keine Gläser vohanden!"),
//            Text("Füge jetzt dein erstes Glas hinzu!")
//          ],
//        ),
//      );
//    } else {
//      return ListView.builder(
//        itemCount: viewModel.drink.sizes.length,
//        itemBuilder: (BuildContext context, int index) {
//          return Container(
//            padding: EdgeInsets.all(16.0),
//            child: Center(
//              child: RawMaterialButton(
//                onPressed: () {
//                  Scaffold.of(context)
//                    ..removeCurrentSnackBar()
//                    ..showSnackBar(
//                        SnackBar(content: Text("Erfolgreich Getrunken!")));
//                  viewModel.doUseForSize(index);
//                },
//                fillColor: colors[index % 9],
//                shape: CircleBorder(),
//                child: Container(
//                  width: 96.0,
//                  height: 96.0,
//                  child: Center(
//                    child: Text(
//                      viewModel.drink.sizes[index].value.toString() + "l",
//                      style: TextStyle(
//                          color: Color(0xffffffff),
//                          fontWeight: FontWeight.w700),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          );
//        },
//      );
//    }
//  }
//}
