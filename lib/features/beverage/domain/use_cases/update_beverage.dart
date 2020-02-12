import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/domain/repositories/beverage_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateBeverage implements UseCase<Beverage, UpdateBeverageParams> {
  UpdateBeverage(this.repository);

  final BeverageRepository repository;

  @override
  Future<Either<Failure, Beverage>> call(UpdateBeverageParams params) {
    return repository.updateBeverage(params);
  }
}
