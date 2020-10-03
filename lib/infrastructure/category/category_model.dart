import 'package:bierzaehler/domain/category/category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'category_model.g.dart';

@JsonSerializable(nullable: false)
class CategoryModel extends Category {
  const CategoryModel({@required this.catID, @required String name}) : super(id: catID, name: name);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  final int catID;
}
