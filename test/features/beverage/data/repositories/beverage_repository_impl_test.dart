import 'dart:ui';

import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/beverage/data/data_sources/beverage_local_data_source.dart';
import 'package:bierzaehler/features/beverage/data/repositories/beverage_repsository_impl.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock implements BeverageLocalDataSource {}

void main() {
  BeverageRepositoryImpl repository;
  MockLocalDataSource localDataSource;

  final tBeverages = [
    Beverage(
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
    localDataSource = MockLocalDataSource();
    repository = BeverageRepositoryImpl(localDataSource: localDataSource);
  });

  group('getAllBeverages', () {
    test('should return all Beverages', () async {

      when(localDataSource.getAllBeverages())
          .thenAnswer((_) async => tBeverages);

      final result = await repository.getAllBeverages();
      verify(localDataSource.getAllBeverages());
      expect(result, Right(tBeverages));
    });

    test('shoult return NoDataFailure when there is no data selected', ()async{
      when(localDataSource.getAllBeverages()).thenAnswer((_)async=>[]);

      final result = await repository.getAllBeverages();
      verify(localDataSource.getAllBeverages());
      expect(result, Left(NoDataFailure()));
    });
  });
}
