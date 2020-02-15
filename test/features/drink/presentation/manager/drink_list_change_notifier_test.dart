import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:bierzaehler/features/drink/domain/entities/price.dart';
import 'package:bierzaehler/features/drink/domain/use_cases/get_all_drinks_for_beverage.dart';
import 'package:bierzaehler/features/drink/presentation/manager/drink_list_cange_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetAllDrinksForBeverage extends Mock
    implements GetAllDrinksForBeverage {}

void main() {
  MockGetAllDrinksForBeverage mockGetAllDrinksForBeverage;
  DrinkListChangeNotifier drinkListChangeNotifier;

  setUp(() {
    mockGetAllDrinksForBeverage = MockGetAllDrinksForBeverage();
    drinkListChangeNotifier = DrinkListChangeNotifier(
        getAllDrinksForBeverage: mockGetAllDrinksForBeverage);
  });

  group('syncDrinksList', () {
    const List<Drink> tDrinks = <Drink>[
      Drink(
        drinkID: 1,
        size: 0.33,
        prices: <Price>[
          Price(priceID: 1, price: 2.0),
          Price(priceID: 2, price: 2.5),
        ],
      ),
      Drink(
        drinkID: 2,
        size: 0.5,
        prices: <Price>[
          Price(priceID: 3, price: 3.0),
          Price(priceID: 4, price: 3.5),
        ],
      ),
    ];
    test('test successful data request', () async {
      when(mockGetAllDrinksForBeverage(
              const GetAllDrinksForBeverageParams(beverageID: 1)))
          .thenAnswer((_) async => const Right<Failure, List<Drink>>(tDrinks));

      await drinkListChangeNotifier.syncDrinksList(beverageID: 1);
      expect(drinkListChangeNotifier.loadingStatus, LoadingStatus.complete);
      expect(drinkListChangeNotifier.drinksList,
          const Right<Failure, List<Drink>>(tDrinks));
    });

    test('test Failure', () async {
      when(mockGetAllDrinksForBeverage(
              const GetAllDrinksForBeverageParams(beverageID: 1)))
          .thenAnswer((_) async => Left<Failure, List<Drink>>(NoDataFailure()));
      await drinkListChangeNotifier.syncDrinksList(beverageID: 1);
      expect(drinkListChangeNotifier.loadingStatus, LoadingStatus.complete);
      expect(drinkListChangeNotifier.drinksList,
          Left<Failure, List<Drink>>(NoDataFailure()));
    });
  });
}
