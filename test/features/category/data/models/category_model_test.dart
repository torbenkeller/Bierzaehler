import 'dart:convert';

import 'package:bierzaehler/infrastructure/category/category_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const CategoryModel tCategoryModel = CategoryModel(
    catID: 1,
    name: 'Bier',
  );

  test('should be a subclass of Beverage', () async {
    expect(tCategoryModel, isA<CategoryModel>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON data is valid', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('category_regular.json')) as Map<String, dynamic>;

      final CategoryModel result = CategoryModel.fromJson(jsonMap);
      expect(result.toJson(), tCategoryModel.toJson());
    });
  });

  group('toJson', () {
    test('should return a JSON Map containing the proper data', () async {
      final Map<String, dynamic> result = tCategoryModel.toJson();

      final Map<String, dynamic> expectedJsonMap =
          json.decode(fixture('category_regular.json')) as Map<String, dynamic>;

      expect(result, expectedJsonMap);
    });
  });
}
