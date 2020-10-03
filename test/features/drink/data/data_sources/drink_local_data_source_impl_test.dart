import 'dart:convert';

import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/infrastructure/drink/drink_local_data_source.dart';
import 'package:bierzaehler/infrastructure/drink/drink_model.dart';
import 'package:bierzaehler/features/drink/data/models/price_model.dart';
import 'package:bierzaehler/domain/drink/price.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/src/exception.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  DrinkLocalDataSource dataSource;
  MockDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockDatabase();
    dataSource = DrinkLocalDataSource(mockDatabase);
  });

  const List<DrinkModel> tDrinks = <DrinkModel>[
    DrinkModel(
      driID: 1,
      size: 0.33,
      pricesConvert: <PriceModel>[
        PriceModel(price: 2.0, priID: 1),
        PriceModel(price: 2.5, priID: 2),
      ],
    ),
    DrinkModel(
      driID: 2,
      size: 0.5,
      pricesConvert: <PriceModel>[
        PriceModel(price: 3.0, priID: 3),
        PriceModel(price: 3.5, priID: 4),
      ],
    ),
  ];

  const DrinkModel tDrink = DrinkModel(
    driID: 1,
    size: 0.33,
    pricesConvert: <PriceModel>[PriceModel(priID: 1, price: 2.0)],
  );

  group('getAllDrinksForBeverage', () {
    const GetAllDrinksForBeverageParams params =
        GetAllDrinksForBeverageParams(beverageID: 1);
    final List<Map<String, dynamic>> tData = List<Map<String, dynamic>>.from(
        json.decode(fixture('drink_list_regular.json')) as List<dynamic>);
    test('should return the list of drinks', () async {
      when(mockDatabase.transaction(any)).thenAnswer((_) async => tData);

      final List<DrinkModel> list =
          await dataSource.getAllDrinksForBeverage(params);

      verify(mockDatabase.transaction(any));
      verifyNoMoreInteractions(mockDatabase);

      expect(list, tDrinks);
    });

    test('should throw exceptions upwords', () async {
      when(mockDatabase.transaction(any)).thenThrow(SqfliteDatabaseException(
          'SQL Error', <String, String>{'sql': 'The wrong sql'}));
      try {
        await dataSource.getAllDrinksForBeverage(params);
      } catch (e) {
        expect(e, isInstanceOf<SqlFailure>());
      }
    });
  });

  group('createNewDrink', () {
    const CreateNewDrinkParams params =
        CreateNewDrinkParams(beverageID: 1, size: 0.33, price: 2.0);
    final Map<String, dynamic> tData =
        json.decode(fixture('drink_regular.json')) as Map<String, dynamic>;
    test('should return the new drink', () async {
      when(mockDatabase.transaction(any)).thenAnswer((_) async => tData);

      final DrinkModel list = await dataSource.createNewDrink(params);

      verify(mockDatabase.transaction(any));
      verifyNoMoreInteractions(mockDatabase);

      expect(list, tDrink);
    });

    test('should throw exceptions upwords', () async {
      when(mockDatabase.transaction(any)).thenThrow(SqfliteDatabaseException(
          'SQL Error', <String, String>{'sql': 'The wrong sql'}));
      try {
        await dataSource.createNewDrink(params);
      } catch (e) {
        expect(e, isInstanceOf<SqlFailure>());
      }
    });
  });
}
