// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrinkModel _$DrinkModelFromJson(Map<String, dynamic> json) {
  return DrinkModel(
    driID: json['driID'] as int,
    pricesConvert: DrinkModel._pricesFromJson(json['prices'] as List),
    size: (json['size'] as num).toDouble(),
  );
}

Map<String, dynamic> _$DrinkModelToJson(DrinkModel instance) => <String, dynamic>{
      'size': instance.size,
      'driID': instance.driID,
      'prices': DrinkModel._pricesToJson(instance.pricesConvert),
    };
