import 'dart:ui';

import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/data/data_sources/beverage_local_data_source.dart';
import 'package:bierzaehler/features/beverage/data/repositories/beverage_repsository_impl.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock implements BeverageLocalDataSource {}

void main() {
  BeverageRepositoryImpl repository;
  MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = BeverageRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('getAllBeverages', () {
    const List<Beverage> tBeverages = <Beverage>[
      Beverage(
        beverageID: 1,
        categoryID: 1,
        name: 'Jever',
        color: Color(0xff7b1fa2),
        alcohol: 0.049,
        category: 'Bier',
        totalDrinkCount: 12,
      )
    ];

    test('should return all Beverages', () async {
      when(mockLocalDataSource.getAllBeverages())
          .thenAnswer((_) async => tBeverages);

      final Either<Failure, List<Beverage>> result =
          await repository.getAllBeverages();
      verify(mockLocalDataSource.getAllBeverages());
      expect(result, const Right<Failure, List<Beverage>>(tBeverages));
    });

    test('shoult return NoDataFailure when there is no data selected',
        () async {
      when(mockLocalDataSource.getAllBeverages())
          .thenAnswer((_) => Future<List<Beverage>>.error(NoDataFailure()));

      final Either<Failure, List<Beverage>> result =
          await repository.getAllBeverages();
      verify(mockLocalDataSource.getAllBeverages());
      expect(result, Left<Failure, List<Beverage>>(NoDataFailure()));
    });
  });

  group('createNewBeverage', () {
    const Beverage tBeverage = Beverage(
      beverageID: 1,
      categoryID: 1,
      name: 'Jever',
      color: Color(0xff7b1fa2),
      alcohol: 0.049,
      category: 'Bier',
      totalDrinkCount: 12,
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

      expect(result, const Right<Failure, Beverage>(tBeverage));
    });

    test('shoult return ArgumentFailure when there is no data selected',
        () async {
      when(mockLocalDataSource.createNewBeverage(params))
          .thenAnswer((_) => Future<Beverage>.error(ArgumentFailure()));

      final Either<Failure, Beverage> result =
          await repository.createNewBeverage(params);
      verify(mockLocalDataSource.createNewBeverage(params));
      expect(result, Left<Failure, Beverage>(ArgumentFailure()));
    });
  });
}
