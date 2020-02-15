// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) {
  return PriceModel(
    priID: json['priID'] as int,
    price: (json['price'] as num).toDouble(),
  );
}

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'price': instance.price,
      'priID': instance.priID,
    };
