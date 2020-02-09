import 'dart:ui';

import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'beverage_model.g.dart';

@JsonSerializable(nullable: false)
class BeverageModel extends Beverage {
  BeverageModel({
    @required this.bevID,
    @required this.catID,
    @required String name,
    @required String category,
    @required this.colorNum,
    @required double alcohol,
    @required int totalDrinkCount,
  }) : super(
    beverageID: bevID,
    categoryID: catID,
    name: name,
    category: category,
    color: Color(colorNum),
    alcohol: alcohol,
    totalDrinkCount: totalDrinkCount,
  );

  factory BeverageModel.fromJson(Map<String, dynamic> json) =>
      _$BeverageModelFromJson(json);


  @JsonKey(name: 'color')
  final int colorNum;

  final int bevID;
  final int catID;

  Map<String, dynamic> toJson() => _$BeverageModelToJson(this);
}
