import 'dart:ui';

import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/infrastructure/beverages/i_beverage_local_data_source.dart';
import 'package:bierzaehler/infrastructure/beverages/beverage_model.dart';
import 'package:bierzaehler/infrastructure/beverages/beverage_repsository.dart';
import 'package:bierzaehler/domain/beverages/beverage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock implements IBeverageLocalDataSource {}

void main() {
  BeverageRepository repository;
  MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = BeverageRepository(localDataSource: mockLocalDataSource);
  });

  group('getAllBeverages', () {
    final List<BeverageModel> tBeverages = <BeverageModel>[
      BeverageModel(
        name: 'Jever',
        alcohol: 0.049,
        category: 'Bier',
        totalDrinkCount: 12,
        catID: 1,
        colorNum: 0xff7b1fa2,
        bevID: 1,
      )
    ];

    test('should return all Beverages', () async {
      when(mockLocalDataSource.getAllBeverages())
          .thenAnswer((_) async => tBeverages);

      final Either<Failure, List<Beverage>> result =
          await repository.getAllBeverages();
      verify(mockLocalDataSource.getAllBeverages());
      expect(result, Right<Failure, List<BeverageModel>>(tBeverages));
    });

    test('shoult return NoDataFailure when there is no data selected',
        () async {
      when(mockLocalDataSource.getAllBeverages()).thenAnswer(
          (_) => Future<List<BeverageModel>>.error(NoDataFailure()));

      final Either<Failure, List<Beverage>> result =
          await repository.getAllBeverages();
      verify(mockLocalDataSource.getAllBeverages());
      expect(result, Left<Failure, List<Beverage>>(NoDataFailure()));
    });
  });

  group('createNewBeverage', () {
    final BeverageModel tBeverage = BeverageModel(
      name: 'Jever',
      alcohol: 0.049,
      category: 'Bier',
      totalDrinkCount: 12,
      catID: 1,
      colorNum: 0xff7b1fa2,
      bevID: 1,
    );

    const CreateBeverageParams params = CreateBeverageParams(
        name: 'Jever', alcohol: 0.049, color: 0xff7b1fa2, categoryName: 'Bier');

    test('should return created beverage', () async {
      when(mockLocalDataSource.createNewBeverage(params))
          .thenAnswer((_) async => tBeverage);

      final Either<Failure, Beverage> result =
          await repository.createNewBeverage(params);

      verify(mockLocalDataSource.createNewBeverage(params));
      verifyNoMoreInteractions(mockLocalDataSource);

      expect(result, Right<Failure, BeverageModel>(tBeverage));
    });

    test('shoult return ArgumentFailure when there is no data selected',
        () async {
      when(mockLocalDataSource.createNewBeverage(params))
          .thenAnswer((_) => Future<BeverageModel>.error(ArgumentFailure()));

      final Either<Failure, Beverage> result =
          await repository.createNewBeverage(params);
      verify(mockLocalDataSource.createNewBeverage(params));
      expect(result, Left<Failure, Beverage>(ArgumentFailure()));
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

    test('should return beverage', () async {
      when(mockLocalDataSource.updateBeverage(params))
          .thenAnswer((_) async => tBeverage);

      final Beverage result = (await repository.updateBeverage(params))
          .fold((_) => null, (Beverage b) => b);

      verify(mockLocalDataSource.updateBeverage(params));
      verifyNoMoreInteractions(mockLocalDataSource);
      expect(result, tBeverage);
    });

    test('should return failure', () async {
      when(mockLocalDataSource.updateBeverage(params)).thenAnswer((_) async {
        throw ArgumentFailure();
      });
      final Failure result = (await repository.updateBeverage(params))
          .fold((Failure f) => f, (_) => null);

      verify(mockLocalDataSource.updateBeverage(params));
      verifyNoMoreInteractions(mockLocalDataSource);
      expect(result, ArgumentFailure());
    });
  });
}
