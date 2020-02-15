import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/data/data_sources/drink_local_data_source.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:bierzaehler/features/drink/domain/repositories/drink_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:bierzaehler/core/platform/repository_extension.dart';

class DrinkRepositoryImpl implements DrinkRepository {
  const DrinkRepositoryImpl({@required this.localDataSource});

  final DrinkLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Drink>>> getAllDrinksForBeverage(
      GetAllDrinksForBeverageParams params) {
    return Task<List<Drink>>(
            () => localDataSource.getAllDrinksForBeverage(params))
        .attempt()
        .mapLeftToFailure<List<Drink>>()
        .run();
  }
}
