import 'package:bierzaehler/infrastructure/category/category_model.dart';

abstract class ICategoryLocalDataSource{
  Future<List<CategoryModel>> getAllCategories();
}