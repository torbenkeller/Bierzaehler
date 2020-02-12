import 'dart:ui';

import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/domain/repositories/beverage_repository.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/update_beverage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBeverageRepository extends Mock implements BeverageRepository {}

void main() {
  UpdateBeverage useCase;
  MockBeverageRepository mockBeverageRepository;

  setUp(() {
    mockBeverageRepository = MockBeverageRepository();
    useCase = UpdateBeverage(mockBeverageRepository);
  });

  const Beverage tBeverage = Beverage(
    beverageID: 1,
    categoryID: 1,
    name: 'Jever',
    color: Color(0xff7b1fa2),
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
  group('updateBeverage', () {
    test('shold return beverage', () async {
      when(mockBeverageRepository.updateBeverage(params))
          .thenAnswer((_) async => const Right<Failure, Beverage>(tBeverage));

      final Either<Failure, Beverage> result = await useCase(params);
      verify(mockBeverageRepository.updateBeverage(params));
      verifyNoMoreInteractions(mockBeverageRepository);
      expect(result, const Right<Failure, Beverage>(tBeverage));
    });

    test('should return failure', () async {
      when(mockBeverageRepository.updateBeverage(params))
          .thenAnswer((_) async => Left<Failure, Beverage>(ArgumentFailure()));

      final Either<Failure, Beverage> result = await useCase(params);
      verify(mockBeverageRepository.updateBeverage(params));
      verifyNoMoreInteractions(mockBeverageRepository);
      expect(result, Left<Failure, Beverage>(ArgumentFailure()));
    });
  });
}
