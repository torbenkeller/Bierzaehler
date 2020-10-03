import 'dart:ui';

import 'package:meta/meta.dart';

class Beverage {
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
}
