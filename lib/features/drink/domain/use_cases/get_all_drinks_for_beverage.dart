import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:bierzaehler/features/drink/domain/repositories/drink_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllDrinksForBeverage
    implements UseCase<List<Drink>, GetAllDrinksForBeverageParams> {
  const GetAllDrinksForBeverage(this.repository);

  final DrinkRepository repository;

  @override
  Future<Either<Failure, List<Drink>>> call(
      GetAllDrinksForBeverageParams params) {
    return repository.getAllDrinksForBeverage(params);
  }
}
