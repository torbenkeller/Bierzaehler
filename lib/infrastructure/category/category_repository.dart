import 'package:bierzaehler/domain/category/category.dart';
import 'package:bierzaehler/domain/category/i_category_repoitory.dart';
import 'package:bierzaehler/infrastructure/category/i_category_local_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@LazySingleton(as: ICategoryRepository)
class CategoryRepository implements ICategoryRepository {
  CategoryRepository({@required this.localDataSource});

  final ICategoryLocalDataSource localDataSource;

  @override
  Future<List<Category>> getAllCategories() {
    return localDataSource.getAllCategories();
  }
}
