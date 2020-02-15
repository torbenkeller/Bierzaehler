import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/category/data/data_sources/category_local_data_source.dart';
import 'package:bierzaehler/features/category/data/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  CategoryLocalDataSourceImpl(this.database);

  final Database database;

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final List<CategoryModel> result =
          (await database.rawQuery('select * from category'))
              .map<Map<String, dynamic>>(
                  (dynamic map) => map as Map<String, dynamic>)
              .map<CategoryModel>(
                  (Map<String, dynamic> map) => CategoryModel.fromJson(map))
              .toList();
      if (result.isEmpty) throw NoDataFailure();
      return result;
    } on DatabaseException {
      throw SqlFailure();
    }
  }
}
