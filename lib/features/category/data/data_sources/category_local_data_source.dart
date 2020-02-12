import 'package:bierzaehler/features/category/data/models/category_model.dart';

abstract class CategoryLocalDataSource{
  Future<List<CategoryModel>> getAllCategories();
}