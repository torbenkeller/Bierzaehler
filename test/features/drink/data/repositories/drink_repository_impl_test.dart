import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/data/data_sources/drink_local_data_source.dart';
import 'package:bierzaehler/features/drink/data/models/drink_model.dart';
import 'package:bierzaehler/features/drink/data/models/price_model.dart';
import 'package:bierzaehler/features/drink/data/repositories/drink_repository_impl.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock implements DrinkLocalDataSource {}

void main() {
  DrinkRepositoryImpl repository;
  MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = DrinkRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('getAllDrinksForBeverage', () {
    const GetAllDrinksForBeverageParams params =
        GetAllDrinksForBeverageParams(beverageID: 1);
    const List<DrinkModel> tDrinks = <DrinkModel>[
      DrinkModel(
        driID: 1,
        size: 0.33,
        pricesConvert: <PriceModel>[
          PriceModel(price: 1.5, priID: 1),
          PriceModel(price: 2, priID: 2),
        ],
      ),
      DrinkModel(
        driID: 2,
        size: 0.5,
        pricesConvert: <PriceModel>[
          PriceModel(price: 2.5, priID: 3),
          PriceModel(price: 3, priID: 4),
        ],
      ),
    ];

    test('should return all Drinks for Beverage', () async {
      when(mockLocalDataSource.getAllDrinksForBeverage(params))
          .thenAnswer((_) async => tDrinks);

      final Either<Failure, List<Drink>> result =
          await repository.getAllDrinksForBeverage(params);
      verify(mockLocalDataSource.getAllDrinksForBeverage(params));
      expect(result, const Right<Failure, List<DrinkModel>>(tDrinks));
    });

    test('shoult return NoDataFailure when there is no data', () async {
      when(mockLocalDataSource.getAllDrinksForBeverage(params))
          .thenAnswer((_) => Future<List<DrinkModel>>.error(NoDataFailure()));

      final Either<Failure, List<Drink>> result =
          await repository.getAllDrinksForBeverage(params);
      verify(mockLocalDataSource.getAllDrinksForBeverage(params));
      expect(result, Left<Failure, List<Drink>>(NoDataFailure()));
    });
  });

  group('createNewDrink', () {
    const CreateNewDrinkParams params =
        CreateNewDrinkParams(beverageID: 1, price: 1, size: 0.33);
    const DrinkModel tDrink = DrinkModel(
      driID: 1,
      size: 0.33,
      pricesConvert: <PriceModel>[
        PriceModel(price: 1, priID: 1),
      ],
    );

    test('should return new Drink', () async {
      when(mockLocalDataSource.createNewDrink(params))
          .thenAnswer((_) async => tDrink);

      final Either<Failure, Drink> result =
          await repository.createNewDrink(params);
      verify(mockLocalDataSource.createNewDrink(params));
      expect(result, const Right<Failure, DrinkModel>(tDrink));
    });

    test('shoult return NoDataFailure when there is no data selected',
        () async {
      when(mockLocalDataSource.createNewDrink(params))
          .thenAnswer((_) => Future<DrinkModel>.error(NoDataFailure()));

      final Either<Failure, Drink> result =
          await repository.createNewDrink(params);
      verify(mockLocalDataSource.createNewDrink(params));
      expect(result, Left<Failure, List<Drink>>(NoDataFailure()));
    });
  });
}
