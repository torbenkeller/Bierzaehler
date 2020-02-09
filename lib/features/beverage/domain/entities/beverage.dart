import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Beverage extends Equatable {
  const Beverage({
    @required this.beverageID,
    @required this.categoryID,
    @required this.name,
    @required this.category,
    @required this.color,
    @required this.alcohol,
    @required this.totalDrinkCount,
  });

  final int beverageID;
  final int categoryID;
  final String name;
  final String category;
  final Color color;
  final double alcohol;
  final int totalDrinkCount;

  @override
  List<Object> get props => <Object>[
        beverageID,
        categoryID,
        name,
        category,
        color,
        alcohol,
        totalDrinkCount
      ];
}
