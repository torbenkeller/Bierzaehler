import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:bierzaehler/features/drink/domain/repositories/drink_repository.dart';
import 'package:dartz/dartz.dart';

class CreateNewDrink extends UseCase<Drink, CreateNewDrinkParams> {
  CreateNewDrink(this.repository);

  final DrinkRepository repository;

  @override
  Future<Either<Failure, Drink>> call(CreateNewDrinkParams params) {
    return repository.createNewDrink(params);
  }
}
