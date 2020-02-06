import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/beverage/data/data_sources/beverage_local_data_source.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/domain/repositories/beverage_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class BeverageRepositoryImpl implements BeverageRepository {
  BeverageRepositoryImpl({@required this.localDataSource});

  final BeverageLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Beverage>>> getAllBeverages() async {
    final List<Beverage> result = await localDataSource.getAllBeverages();
    return (result.isEmpty)
        ? Left<Failure, List<Beverage>>(NoDataFailure())
        : Right<Failure, List<Beverage>>(result);
  }
}