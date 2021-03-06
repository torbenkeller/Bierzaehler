import 'dart:convert';

import 'package:bierzaehler/infrastructure/beverages/beverage_model.dart';
import 'package:bierzaehler/domain/beverages/beverage.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final BeverageModel tBeverageModel = BeverageModel(
    bevID: 1,
    catID: 1,
    name: 'Jever',
    colorNum: 0xff7b1fa2,
    alcohol: 0.049,
    category: 'Bier',
    totalDrinkCount: 12,
  );

  test('should be a subclass of Beverage', () async {
    expect(tBeverageModel, isA<Beverage>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON data is valid', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('beverage_regular.json')) as Map<String, dynamic>;

      final BeverageModel result = BeverageModel.fromJson(jsonMap);
      expect(result, tBeverageModel);
    });
  });

  group('toJson', () {
    test('should return a JSON Map containing the proper data', () async {
      final Map<String, dynamic> result = tBeverageModel.toJson();

      final Map<String, dynamic> expectedJsonMap =
          json.decode(fixture('beverage_regular.json')) as Map<String, dynamic>;

      expect(result, expectedJsonMap);
    });
  });
}
