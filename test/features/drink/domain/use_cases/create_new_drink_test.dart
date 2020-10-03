import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/domain/drink/drink.dart';
import 'package:bierzaehler/domain/drink/price.dart';
import 'package:bierzaehler/domain/drink/i_drink_repository.dart';
import 'package:bierzaehler/features/drink/domain/use_cases/create_new_drink.dart';
import 'package:bierzaehler/features/drink/domain/use_cases/get_all_drinks_for_beverage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDrinkRepository extends Mock implements IDrinkRepository {}

void main() {
  CreateNewDrink useCase;
  MockDrinkRepository mockDrinkRepository;

  setUp(() {
    mockDrinkRepository = MockDrinkRepository();
    useCase = CreateNewDrink(mockDrinkRepository);
  });

  const Drink tDrink = Drink(
    drinkID: 1,
    size: 0.33,
    prices: <Price>[
      Price(price: 1.5, priceID: 1),
      Price(price: 2, priceID: 2),
    ],
  );

  const CreateNewDrinkParams params =
      CreateNewDrinkParams(beverageID: 1, size: 0.33, price: 2.0);
  group('createNewDrink', () {
    test('shold return drink', () async {
      when(mockDrinkRepository.createNewDrink(params))
          .thenAnswer((_) async => const Right<Failure, Drink>(tDrink));

      final Either<Failure, Drink> result = await useCase(params);
      verify(mockDrinkRepository.createNewDrink(params));
      verifyNoMoreInteractions(mockDrinkRepository);
      expect(result, const Right<Failure, Drink>(tDrink));
    });
    test('shold return failure', () async {
      when(mockDrinkRepository.createNewDrink(params))
          .thenAnswer((_) async => Left<Failure, Drink>(SqlFailure()));

      final Either<Failure, Drink> result = await useCase(params);
      verify(mockDrinkRepository.createNewDrink(params));
      verifyNoMoreInteractions(mockDrinkRepository);
      expect(result, Left<Failure, Drink>(SqlFailure()));
    });
  });
}
