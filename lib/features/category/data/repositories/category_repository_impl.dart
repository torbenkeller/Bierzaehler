import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/category/data/data_sources/category_local_data_source.dart';
import 'package:bierzaehler/features/category/domain/entities/category.dart';
import 'package:bierzaehler/features/category/domain/repositories/category_repoitory.dart';
import 'package:bierzaehler/core/platform/repository_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  CategoryRepositoryImpl({@required this.localDataSource});

  final CategoryLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() {
    return Task<List<Category>>(() => localDataSource.getAllCategories())
        .attempt()
        .mapLeftToFailure<List<Category>>()
        .run();
  }

}