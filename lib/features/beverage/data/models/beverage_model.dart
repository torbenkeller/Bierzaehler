import 'dart:ui';

import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable(nullable: false)
class BeverageModel extends Beverage {
  BeverageModel({
    @required int beverageID,
    @required int categoryID,
    @required String name,
    @required String category,
    @required Color color,
    @required double alcohol,
    @required double totalDrinkAmount,
    @required int totalDrinkCount,
  }) : super(
          beverageID: beverageID,
          categoryID: categoryID,
          name: name,
          category: category,
          color: color,
          alcohol: alcohol,
          totalDrinkAmount: totalDrinkAmount,
          totalDrinkCount: totalDrinkCount,
        );

  factory BeverageModel.fromJson(Map<String, dynamic> json) =>
      _$BeverageModelFromJson(json);
  Map<String, dynamic> toJson() => $_BeverageModelToJson(this);
}
