import 'package:bierzaehler/infrastructure/category/category_model.dart';
import 'package:bierzaehler/infrastructure/category/i_category_local_data_source.dart';
import 'package:bierzaehler/infrastructure/core/i_sqlite_connector.dart';
import 'package:bierzaehler/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: ICategoryLocalDataSource)
class CategoryLocalDataSource implements ICategoryLocalDataSource {
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final database = await getIt<ISqliteConnector>().getDatabaseInstance();

    try {
      final List<CategoryModel> result = (await database.rawQuery('select * from category'))
          .map<Map<String, dynamic>>((dynamic map) => map as Map<String, dynamic>)
          .map<CategoryModel>((Map<String, dynamic> map) => CategoryModel.fromJson(map))
          .toList();
      if (result.isEmpty) throw Exception();
      //if (result.isEmpty) throw NoDataFailure();
      return result;
    } on DatabaseException {
      rethrow;
      //throw SqlFailure();
    }
  }
}
