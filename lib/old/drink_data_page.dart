//import 'package:bierzaehler/my_flutter_app_icons.dart';
//import 'package:bierzaehler/objects/drink.dart';
//import 'package:bierzaehler/old.objects/viewModels/drink.dart';
//import 'package:bierzaehler/widgets/fancy_data_widget.dart';
//import 'package:flutter/material.dart';
//
//class DrinkDataPage extends StatelessWidget {
//  final DrinkViewModel viewModel;
//
//  DrinkDataPage({@required this.viewModel});
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
//  static const TextStyle descriptionStyle = TextStyle();
//  static const TextStyle headlineStyle = TextStyle(fontSize: 22.0);
//  static const TextStyle contentStyle =
//      TextStyle(fontWeight: FontWeight.w900, color: Colors.white);
//  static const TextStyle contentDescriptionStyle =
//      TextStyle(fontWeight: FontWeight.w400, color: Colors.white);
//
//  @override
//  Widget build(BuildContext context) {
//    return SingleChildScrollView(
//      child: Container(
//          padding: EdgeInsets.all(16.0),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                "Getrunken",
//                style: headlineStyle,
//              ),
//              Padding(
//                padding: EdgeInsets.only(bottom: 8.0),
//              ),
//              Row(
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  FancyDataWidget(
//                    color: colors[2],
//                    content: Text(
//                      viewModel.drink.drunkenTotalVol.toStringAsFixed(2) + "l",
//                      style: contentStyle,
//                    ),
//                    description: Text(
//                      viewModel.drink.name.toString(),
//                      style: descriptionStyle,
//                    ),
//                  ),
//                  FancyDataWidget(
//                    color: colors[2],
//                    content: Text(
//                      viewModel.drink.drunkenTotalAlk.toStringAsFixed(2) + "g",
//                      style: contentStyle,
//                    ),
//                    description: Text(
//                      "Alkohol",
//                      style: descriptionStyle,
//                    ),
//                  ),
//                  FancyDataWidget(
//                    color: colors[2],
//                    content: Text(
//                      viewModel.drink.daysSinceFirstDrink.toStringAsFixed(2),
//                      style: contentStyle,
//                    ),
//                    description: Text(
//                      "Tage",
//                      style: descriptionStyle,
//                    ),
//                  ),
//                ],
//              ),
//              Padding(padding: EdgeInsets.only(bottom: 16.0)),
//              Row(
//                children: <Widget>[
//                  Icon(MyFlutterApp.average),
//                  Text(
//                    "Heute",
//                    style: headlineStyle,
//                  )
//                ],
//              ),
//              Padding(
//                padding: EdgeInsets.only(bottom: 8.0),
//              ),
//              Row(
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  FancyDataWidget(
//                    color: colors[5],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageDayVol(AverageTime.TODAY)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageDayAlk(AverageTime.TODAY)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Tag",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                  FancyDataWidget(
//                    color: colors[5],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageMonthVol(AverageTime.TODAY)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageMonthAlk(AverageTime.TODAY)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Monat",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                  FancyDataWidget(
//                    color: colors[5],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageYearVol(AverageTime.TODAY)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageYearAlk(AverageTime.TODAY)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Jahr",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                ],
//              ),
//              Padding(padding: EdgeInsets.only(bottom: 16.0)),
//              Row(
//                children: <Widget>[
//                  Icon(MyFlutterApp.average),
//                  Text(
//                    "Gestern",
//                    style: headlineStyle,
//                  )
//                ],
//              ),
//              Padding(
//                padding: EdgeInsets.only(bottom: 8.0),
//              ),
//              Row(
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  FancyDataWidget(
//                    color: colors[7],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageDayVol(AverageTime.YESTERDAY)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageDayAlk(AverageTime.YESTERDAY)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Tag",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                  FancyDataWidget(
//                    color: colors[7],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageMonthVol(AverageTime.YESTERDAY)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageMonthAlk(AverageTime.YESTERDAY)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Monat",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                  FancyDataWidget(
//                    color: colors[7],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageYearVol(AverageTime.YESTERDAY)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageYearAlk(AverageTime.YESTERDAY)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Jahr",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                ],
//              ),
//              Padding(padding: EdgeInsets.only(bottom: 16.0)),
//              Row(
//                children: <Widget>[
//                  Icon(MyFlutterApp.average),
//                  Text(
//                    "Woche",
//                    style: headlineStyle,
//                  )
//                ],
//              ),
//              Padding(
//                padding: EdgeInsets.only(bottom: 8.0),
//              ),
//              Row(
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  FancyDataWidget(
//                    color: colors[4],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageDayVol(AverageTime.WEEK)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageDayAlk(AverageTime.WEEK)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Tag",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                  FancyDataWidget(
//                    color: colors[4],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageMonthVol(AverageTime.WEEK)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageMonthAlk(AverageTime.WEEK)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Monat",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                  FancyDataWidget(
//                    color: colors[4],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageYearVol(AverageTime.WEEK)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageYearAlk(AverageTime.WEEK)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Jahr",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                ],
//              ),Padding(padding: EdgeInsets.only(bottom: 16.0)),
//              Row(
//                children: <Widget>[
//                  Icon(MyFlutterApp.average),
//                  Text(
//                    "Monat",
//                    style: headlineStyle,
//                  )
//                ],
//              ),
//              Padding(
//                padding: EdgeInsets.only(bottom: 8.0),
//              ),
//              Row(
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  FancyDataWidget(
//                    color: colors[3],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageDayVol(AverageTime.MONTH)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageDayAlk(AverageTime.MONTH)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Tag",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                  FancyDataWidget(
//                    color: colors[3],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageMonthVol(AverageTime.MONTH)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageMonthAlk(AverageTime.MONTH)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Monat",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                  FancyDataWidget(
//                    color: colors[3],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageYearVol(AverageTime.MONTH)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageYearAlk(AverageTime.MONTH)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Jahr",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                ],
//              ),Padding(padding: EdgeInsets.only(bottom: 16.0)),
//              Row(
//                children: <Widget>[
//                  Icon(MyFlutterApp.average),
//                  Text(
//                    "Jahr",
//                    style: headlineStyle,
//                  )
//                ],
//              ),
//              Padding(
//                padding: EdgeInsets.only(bottom: 8.0),
//              ),
//              Row(
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  FancyDataWidget(
//                    color: colors[1],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageDayVol(AverageTime.YEAR)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageDayAlk(AverageTime.YEAR)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Tag",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                  FancyDataWidget(
//                    color: colors[1],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageMonthVol(AverageTime.YEAR)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageMonthAlk(AverageTime.YEAR)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Monat",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                  FancyDataWidget(
//                    color: colors[1],
//                    content: Column(
//                        mainAxisSize: MainAxisSize.max,
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                              viewModel.drink
//                                      .averageYearVol(AverageTime.YEAR)
//                                      .toStringAsFixed(2) +
//                                  "l",
//                              style: contentStyle),
//                          Padding(
//                            padding: EdgeInsets.only(bottom: 8.0),
//                          ),
//                          Text(
//                            viewModel.drink
//                                    .averageYearAlk(AverageTime.YEAR)
//                                    .toStringAsFixed(2) +
//                                "g",
//                            style: contentStyle,
//                          ),
//                        ]),
//                    description: Row(children: [
//                      Icon(MyFlutterApp.average),
//                      Text(
//                        "Jahr",
//                        style: descriptionStyle,
//                      )
//                    ]),
//                  ),
//                ],
//              ),
//            ],
//          )),
//    );
//  }
//}
