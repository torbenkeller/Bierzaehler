import 'dart:ui';

import 'package:bierzaehler/features/beverage/data/data_sources/beverage_local_data_source_impl.dart';
import 'package:bierzaehler/features/beverage/data/models/beverage_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/src/exception.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  BeverageLocalDataSourceImpl dataSource;
  MockDatabase mockDatabase;

  final tData = [
    {
      "BevID": 1,
      "CatID": 1,
      "Name": "Jever",
      "Color": 4286259106,
      "Alcohol": 0.049,
      "Category": "Bier",
      "TotalDrinkAmount": 4.0,
      "TotalDrinkCount": 12
    }
  ];

  final tBeverages = [
    BeverageModel(
      beverageID: 1,
      categoryID: 1,
      name: 'Jever',
      color: Color(0xff7b1fa2),
      alcohol: 0.049,
      category: 'Bier',
      totalDrinkAmount: 4,
      totalDrinkCount: 12,
    )
  ];

  setUp(() {
    mockDatabase = MockDatabase();
    dataSource = BeverageLocalDataSourceImpl(database: mockDatabase);
  });

  group('getAllBeverages', () {
    test('should return the list of beverages', () async {
      when(mockDatabase.rawQuery(any)).thenAnswer((_) async => tData);

      final result = await dataSource.getAllBeverages();

      verify(mockDatabase.rawQuery(any));
      verifyNoMoreInteractions(mockDatabase);
      expect(result, tBeverages);
    });

    test('should throw exceptions upwords', () async {
      when(mockDatabase.rawQuery(any)).thenThrow(
          SqfliteDatabaseException('SQL Error', {'sql': 'The wrong sql'}));
      try {
        final result = await dataSource.getAllBeverages();
      } catch (e) {
        expect(e, isInstanceOf<DatabaseException>());
      }
    });
  });
}
