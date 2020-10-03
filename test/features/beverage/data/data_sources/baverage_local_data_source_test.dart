import 'dart:convert';
import 'dart:ui';
import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/infrastructure/beverages/beverage_local_data_source.dart';
import 'package:bierzaehler/infrastructure/beverages/beverage_model.dart';
import 'package:bierzaehler/domain/beverages/beverage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/src/exception.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  BeverageLocalDataSource dataSource;
  MockDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockDatabase();
    dataSource = BeverageLocalDataSource(mockDatabase);
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

  group('updateBeverage', () {
    final BeverageModel tBeverage = BeverageModel(
      bevID: 1,
      catID: 1,
      name: 'Jever',
      colorNum: 0xff7b1fa2,
      alcohol: 0.049,
      category: 'Bier',
      totalDrinkCount: 12,
    );

    const UpdateBeverageParams params = UpdateBeverageParams(
      old: Beverage(
        beverageID: 1,
        categoryID: 2,
        name: 'Riesling',
        color: Color(0x00000000),
        alcohol: 0.15,
        category: 'Wein',
        totalDrinkCount: 12,
      ),
      newName: 'Jever',
      newAlcohol: 0.049,
      newColor: 0xff7b1fa2,
      newCategoryName: 'Bier',
    );
    test('should return updated beverage', () async {
      when(mockDatabase.transaction(any))
          .thenAnswer((_) async => tBeverage.toJson());

      final BeverageModel result = await dataSource.updateBeverage(params);

      verify(mockDatabase.transaction(any));
      verifyNoMoreInteractions(mockDatabase);
      expect(result, tBeverage);
    });
    test('should throw Failure', ()async{
      when(mockDatabase.transaction(any)).thenAnswer((_) async{
        throw SqfliteDatabaseException('message', 'sql');
      });
      try{
        await dataSource.updateBeverage(params);
        expect(true, false);
      }catch (e){
        expect(e, isA<ArgumentFailure>());
      }
    });
  });
}
