import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/category/domain/entities/category.dart';
import 'package:bierzaehler/features/category/domain/repositories/category_repoitory.dart';
import 'package:dartz/dartz.dart';

class GetAllCategories implements UseCase<List<Category>, NoParams> {
  GetAllCategories(this.repository);

  final CategoryRepository repository;

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) {
    return repository.getAllCategories();
  }
}
