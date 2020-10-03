import 'package:bierzaehler/domain/beverages/i_beverage_repository.dart';
import 'package:bierzaehler/infrastructure/beverages/beverage_model.dart';
import 'package:bierzaehler/infrastructure/beverages/i_beverage_local_data_source.dart';
import 'package:bierzaehler/infrastructure/core/i_sqlite_connector.dart';
import 'package:bierzaehler/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@LazySingleton(as: IBeverageLocalDataSource)
class BeverageLocalDataSource implements IBeverageLocalDataSource {
  @override
  Future<List<BeverageModel>> getAllBeverages() async {
    final database = await getIt<ISqliteConnector>().getDatabaseInstance();

    List<Map<String, dynamic>> result;
    try {
      result = await database.rawQuery('SELECT B.*, C.name as category,'
          ' Count(U.UseID) totalDrinkCount'
          ' FROM Category C join Beverage B using(CatID)'
          ' left join Drink D USING(BevID) left join Price P using(DriID)'
          ' left join Use U using(PriID)'
          ' GROUP BY B.BevID;');
    } on DatabaseException {
      rethrow;
      //throw SqlFailure();
    }
    if (result.isEmpty) throw Exception();
    //if (result.isEmpty) throw NoDataFailure();
    return result.map((Map<String, dynamic> data) => BeverageModel.fromJson(data)).toList();
  }

  @override
  Future<BeverageModel> createNewBeverage(CreateBeverageParams params) async {
    final database = await getIt<ISqliteConnector>().getDatabaseInstance();

    try {
      final Map<String, dynamic> result =
          await database.transaction<Map<String, dynamic>>((Transaction txn) async {
        final List<Map<String, dynamic>> category = await txn.rawQuery('select catID from category '
            'where name = "${params.categoryName}";');

        int categoryID;
        if (category.isEmpty) {
          categoryID = await txn
              .rawInsert('insert into category (name) values(?)', <String>[params.categoryName]);
        } else {
          categoryID = category[0]['catID'] as int;
        }

        final int beverageID = await txn.rawInsert(
            'insert into beverage (catID, name, color, alcohol) '
            'values(?, ?, ?, ?)',
            <dynamic>[categoryID, params.name, params.color, params.alcohol]);
        if (beverageID < 1) throw Exception();
        //if (beverageID < 1) throw ArgumentFailure();

        return <String, dynamic>{
          'alcohol': params.alcohol,
          'name': params.name,
          'totalDrinkCount': 0,
          'category': params.categoryName,
          'bevID': beverageID,
          'catID': categoryID,
          'color': params.color,
        };
      });
      return BeverageModel.fromJson(result);
    } on DatabaseException {
      rethrow;
      //throw ArgumentFailure();
    }
  }

  @override
  Future<BeverageModel> updateBeverage(UpdateBeverageParams params) async {
    final database = await getIt<ISqliteConnector>().getDatabaseInstance();

    try {
      final Map<String, dynamic> result = await database.transaction((Transaction txn) async {
        final List<Map<String, dynamic>> category = await txn.rawQuery(
            'select catID from Category'
            ' where name = ?',
            <String>[params.newCategoryName]);
        int newCategoryID;
        if (category.isEmpty) {
          newCategoryID = await txn.rawInsert(
              'insert into category (name) values (?)', <String>[params.newCategoryName]);
        } else {
          newCategoryID = category[0]['catID'] as int;
        }

        final int beverageID = await txn.rawUpdate(
            'update Beverage '
            'set catID = ?, name = ?, color = ?, alcohol = ? '
            'where bevID = ${params.old.beverageID}',
            <dynamic>[
              newCategoryID,
              params.newName,
              params.newColor,
              params.newAlcohol,
            ]);
        return <String, dynamic>{
          'alcohol': params.newAlcohol,
          'name': params.newName,
          'totalDrinkCount': params.old.totalDrinkCount,
          'category': params.newCategoryName,
          'bevID': beverageID,
          'catID': newCategoryID,
          'color': params.newColor,
        };
      });
      return BeverageModel.fromJson(result);
    } on DatabaseException {
      rethrow;
      //throw ArgumentFailure();
    }
  }
}
