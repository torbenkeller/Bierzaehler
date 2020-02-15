import 'dart:convert';

import 'package:bierzaehler/features/drink/data/models/price_model.dart';
import 'package:bierzaehler/features/drink/domain/entities/price.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const PriceModel tPriceModel = PriceModel(
    priID: 1,
    price: 0.5,
  );

  test('should be a subclass of Price', () async {
    expect(tPriceModel, isA<Price>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON data is valid', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('price_regular.json')) as Map<String, dynamic>;

      final PriceModel result = PriceModel.fromJson(jsonMap);
      expect(result, tPriceModel);
    });
  });

  group('toJson', () {
    test('should return a JSON Map containing the proper data', () async {
      final Map<String, dynamic> result = tPriceModel.toJson();

      final Map<String, dynamic> expectedJsonMap =
          json.decode(fixture('price_regular.json')) as Map<String, dynamic>;

      expect(result, expectedJsonMap);
    });
  });
}
