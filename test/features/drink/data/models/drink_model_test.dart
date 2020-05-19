import 'dart:convert';

import 'package:bierzaehler/features/drink/data/models/drink_model.dart';
import 'package:bierzaehler/features/drink/data/models/price_model.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {

  const DrinkModel tDrinkModel = DrinkModel(
    driID: 1,
    size: 0.33,
    pricesConvert: <PriceModel>[
      PriceModel(priID: 1, price: 2.0),
    ],
  );

  test('should be a subclass of Drink', () async {
    expect(tDrinkModel, isA<Drink>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON data is valid', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('drink_regular.json')) as Map<String, dynamic>;

      final DrinkModel result = DrinkModel.fromJson(jsonMap);
      expect(result, tDrinkModel);
    });
  });

  group('toJson', () {
    test('should return a JSON Map containing the proper data', () async {
      final Map<String, dynamic> result = tDrinkModel.toJson();

      final Map<String, dynamic> expectedJsonMap =
          json.decode(fixture('drink_regular.json')) as Map<String, dynamic>;

      expect(result, expectedJsonMap);
    });
  });
}
