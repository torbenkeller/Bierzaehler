import 'package:bierzaehler/domain/category/category.dart';

abstract class ICategoryRepository {
  Future<List<Category>> getAllCategories();
}
