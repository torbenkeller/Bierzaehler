import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/category/domain/entities/category.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}
