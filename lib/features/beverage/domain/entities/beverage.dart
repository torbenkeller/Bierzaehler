import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Beverage extends Equatable {
  final int beverageID;
  final String name;
  final String category;
  final Color color;
  final double alcohol;
  final double totalDrinkAmount;
  final int totalDrinkCount;

  Beverage({
    @required this.beverageID,
    @required this.name,
    @required this.category,
    @required this.color,
    @required this.alcohol,
    @required this.totalDrinkAmount,
    @required this.totalDrinkCount,
  });

  @override
  List<Object> get props => [
        beverageID,
        name,
        category,
        color,
        alcohol,
        totalDrinkAmount,
        totalDrinkCount
      ];
}
