import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:dartz/dartz.dart';

abstract class DrinkRepository {
  Future<Either<Failure, List<Drink>>> getAllDrinksForBeverage(
      GetAllDrinksForBeverageParams params);

  Future<Either<Failure, Drink>> createNewDrink(CreateNewDrinkParams params);
}
