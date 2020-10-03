import 'package:bierzaehler/domain/drink/price.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_model.g.dart';

@JsonSerializable(nullable: false)
class PriceModel extends Price {
  const PriceModel({
    @required this.priID,
    @required double price,
  }) : super(price: price, priceID: priID);

  factory PriceModel.fromJson(Map<String, dynamic> json) => _$PriceModelFromJson(json);

  final int priID;

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);
}
