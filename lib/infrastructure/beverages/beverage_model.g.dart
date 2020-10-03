// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beverage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeverageModel _$BeverageModelFromJson(Map<String, dynamic> json) {
  return BeverageModel(
    bevID: json['bevID'] as int,
    catID: json['catID'] as int,
    name: json['name'] as String,
    category: json['category'] as String,
    colorNum: json['color'] as int,
    alcohol: (json['alcohol'] as num).toDouble(),
    totalDrinkCount: json['totalDrinkCount'] as int,
  );
}

Map<String, dynamic> _$BeverageModelToJson(BeverageModel instance) => <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'alcohol': instance.alcohol,
      'totalDrinkCount': instance.totalDrinkCount,
      'color': instance.colorNum,
      'bevID': instance.bevID,
      'catID': instance.catID,
    };
