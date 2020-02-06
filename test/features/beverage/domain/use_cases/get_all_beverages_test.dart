import 'dart:ui';

import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/domain/repositories/beverage_repository.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/get_all_beverages.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBeverageRepository extends Mock implements BeverageRepository {}

void main() {
  GetAllBeverages useCase;
  MockBeverageRepository mockBeverageRepository;

  setUp(() {
    mockBeverageRepository = MockBeverageRepository();
    useCase = GetAllBeverages(mockBeverageRepository);
  });

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

  test('should get berverages from the repository', () async {
    when(mockBeverageRepository.getAllBeverages())
        .thenAnswer((_) async => Right(tBeverages));

    final result = await useCase(NoParams());
    expect(result, Right(tBeverages));
    verify(mockBeverageRepository.getAllBeverages());
    verifyNoMoreInteractions(mockBeverageRepository);
  });
}
