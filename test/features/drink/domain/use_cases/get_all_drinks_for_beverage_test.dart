import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:bierzaehler/features/drink/domain/entities/price.dart';
import 'package:bierzaehler/features/drink/domain/repositories/drink_repository.dart';
import 'package:bierzaehler/features/drink/domain/use_cases/get_all_drinks_for_beverage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDrinkRepository extends Mock implements DrinkRepository {}

void main() {
  GetAllDrinksForBeverage useCase;
  MockDrinkRepository mockDrinkRepository;

  setUp(() {
    mockDrinkRepository = MockDrinkRepository();
    useCase = GetAllDrinksForBeverage(mockDrinkRepository);
  });

  const List<Drink> tDrinks = <Drink>[
    Drink(
      drinkID: 1,
      size: 0.33,
      prices: <Price>[
        Price(price: 1.5, priceID: 1),
        Price(price: 2, priceID: 2),
      ],
    ),
    Drink(
      drinkID: 2,
      size: 0.5,
      prices: <Price>[
        Price(price: 2.5, priceID: 3),
        Price(price: 3, priceID: 4),
      ],
    ),
  ];

  const GetAllDrinksForBeverageParams params =
      GetAllDrinksForBeverageParams(beverageID: 1);
  group('getAllDrinksForBeverage', () {
    test('shold return drink', () async {
      when(mockDrinkRepository.getAllDrinksForBeverage(params))
          .thenAnswer((_) async => const Right<Failure, List<Drink>>(tDrinks));

      final Either<Failure, List<Drink>> result = await useCase(params);
      verify(mockDrinkRepository.getAllDrinksForBeverage(params));
      verifyNoMoreInteractions(mockDrinkRepository);
      expect(result, const Right<Failure, List<Drink>>(tDrinks));
    });
    test('shold return failure', () async {
      when(mockDrinkRepository.getAllDrinksForBeverage(params))
          .thenAnswer((_) async => Left<Failure, List<Drink>>(SqlFailure()));

      final Either<Failure, List<Drink>> result = await useCase(params);
      verify(mockDrinkRepository.getAllDrinksForBeverage(params));
      verifyNoMoreInteractions(mockDrinkRepository);
      expect(result, Left<Failure, List<Drink>>(SqlFailure()));
    });
  });
}
