import 'dart:ui';

import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/domain/repositories/beverage_repository.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/create_new_beverage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBeverageRepository extends Mock implements BeverageRepository {}

void main() {
  CreateNewBeverage useCase;
  MockBeverageRepository mockBeverageRepository;

  setUp(() {
    mockBeverageRepository = MockBeverageRepository();
    useCase = CreateNewBeverage(mockBeverageRepository);
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

  const CreateBeverageParams params = CreateBeverageParams(
    name: 'Jever',
    alcohol: 0.049,
    color: 0xff7b1fa2,
    categoryName: 'Bier',
  );

  test('shold return beverage', () async {
    when(mockBeverageRepository.createNewBeverage(params))
        .thenAnswer((_) async => const Right<Failure, Beverage>(tBeverage));

    final Either<Failure, Beverage> result = await useCase(params);
    verify(mockBeverageRepository.createNewBeverage(params));
    verifyNoMoreInteractions(mockBeverageRepository);
    expect(result, const Right<Failure, Beverage>(tBeverage));
  });
}
