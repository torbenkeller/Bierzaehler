import 'dart:convert';
import 'dart:ui';

import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/data/data_sources/beverage_local_data_source_impl.dart';
import 'package:bierzaehler/features/beverage/data/models/beverage_model.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/src/exception.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  BeverageLocalDataSourceImpl dataSource;
  MockDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockDatabase();
    dataSource = BeverageLocalDataSourceImpl(database: mockDatabase);
  });

  group('getAllBeverages', () {
    final List<Map<String, dynamic>> tData =
        (json.decode(fixture('beverage_list_regular.json')) as List<dynamic>)
            .map((dynamic item) => item as Map<String, dynamic>)
            .toList();
    final List<BeverageModel> tBeverages = <BeverageModel>[
      BeverageModel(
        bevID: 1,
        catID: 1,
        name: 'Jever',
        colorNum: 0xff7b1fa2,
        alcohol: 0.049,
        category: 'Bier',
        totalDrinkCount: 12,
      )
    ];
    test('should return the list of beverages', () async {
      when(mockDatabase.rawQuery(any)).thenAnswer((_) async => tData);

      final List<Beverage> result = await dataSource.getAllBeverages();

      verify(mockDatabase.rawQuery(any));
      verifyNoMoreInteractions(mockDatabase);
      expect(result, tBeverages);
    });

    test('should throw exceptions upwords', () async {
      when(mockDatabase.rawQuery(any)).thenThrow(SqfliteDatabaseException(
          'SQL Error', <String, String>{'sql': 'The wrong sql'}));
      try {
        await dataSource.getAllBeverages();
      } catch (e) {
        expect(e, isInstanceOf<SqlFailure>());
      }
    });
  });

  group('createNewBeverage', () {
    final BeverageModel tBeverage = BeverageModel(
      bevID: 1,
      catID: 1,
      name: 'Jever',
      colorNum: 0xff7b1fa2,
      alcohol: 0.049,
      category: 'Bier',
      totalDrinkCount: 12,
    );

    const CreateBeverageParams params = CreateBeverageParams(
        name: 'Jever', alcohol: 0.049, color: 0xff7b1fa2, categoryName: 'Bier');

    test('should return the created beverage', () async {
      when(mockDatabase.transaction(any)).thenAnswer((_) async => json
          .decode(fixture('beverage_regular.json')) as Map<String, dynamic>);

      final Beverage result = await dataSource.createNewBeverage(params);
      verify(mockDatabase.transaction(any));
      verifyNoMoreInteractions(mockDatabase);

      expect(result, tBeverage);
    });
  });
}
