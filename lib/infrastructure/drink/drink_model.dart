import 'package:bierzaehler/domain/drink/drink.dart';
import 'package:bierzaehler/infrastructure/drink/price_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drink_model.g.dart';

@JsonSerializable(nullable: false)
class DrinkModel extends Drink {
  const DrinkModel({
    @required this.driID,
    @required this.pricesConvert,
    @required double size,
  }) : super(prices: pricesConvert, size: size, drinkID: driID);

  factory DrinkModel.fromJson(Map<String, dynamic> json) => _$DrinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrinkModelToJson(this);

  final int driID;

  @JsonKey(name: 'prices', toJson: _pricesToJson, fromJson: _pricesFromJson)
  final List<PriceModel> pricesConvert;

  static List<Map<String, dynamic>> _pricesToJson(List<PriceModel> toConvert) =>
      toConvert.map<Map<String, dynamic>>((PriceModel p) => p.toJson()).toList(growable: false);

  static List<PriceModel> _pricesFromJson(List<dynamic> list) => list
      .map<PriceModel>((dynamic json) => PriceModel.fromJson(json as Map<String, dynamic>))
      .toList(growable: false);
}
