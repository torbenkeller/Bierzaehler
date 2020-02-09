import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:dartz/dartz.dart';

abstract class BeverageRepository {
  Future<Either<Failure, List<Beverage>>> getAllBeverages();

  Future<Either<Failure, Beverage>> createNewBeverage(
      CreateBeverageParams params);
}
