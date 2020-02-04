import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/domain/repositories/beverage_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllBeverages{
  final BeverageRepository repository;

  GetAllBeverages(this.repository);

  Future<Either<Failure, List<Beverage>>> execute() async {
    return await repository.getAllBeverages();
  }
}