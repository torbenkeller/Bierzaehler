import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/data/data_sources/beverage_local_data_source.dart';
import 'package:bierzaehler/features/beverage/data/models/beverage_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

class BeverageLocalDataSourceImpl implements BeverageLocalDataSource {
  const BeverageLocalDataSourceImpl({@required this.database});

  final Database database;

  @override
  Future<List<BeverageModel>> getAllBeverages() async {
    List<Map<String, dynamic>> result;
    try {
      result = await database.rawQuery('SELECT B.*, C.name as category,'
          ' Count(U.UseID) totalDrinkCount'
          ' FROM Category C join Beverage B using(CatID)'
          ' left join Drink D USING(BevID) left join Price P using(DriID)'
          ' left join Use U using(PriID)'
          ' GROUP BY B.BevID;');
    } on DatabaseException {
      throw SqlFailure();
    }
    if (result.isEmpty) throw NoDataFailure();
    return result
        .map((Map<String, dynamic> data) => BeverageModel.fromJson(data))
        .toList();
  }

  @override
  Future<BeverageModel> createNewBeverage(CreateBeverageParams params) async {
    final Map<String, dynamic> result = await database
        .transaction<Map<String, dynamic>>((Transaction txn) async {
      try {
        final List<Map<String, dynamic>> category =
            await txn.rawQuery('select catID from category '
                'where name = "${params.categoryName}";');

        int categoryID;
        if (category.isEmpty) {
          categoryID = await txn.rawInsert(
              'insert into category (name) values(?)',
              <String>[params.categoryName]);
        } else {
          categoryID = category[0]['catID'] as int;
        }

        final int beverageID = await txn.rawInsert(
            'insert into beverage (catID, name, color, alcohol) '
            'values(?, ?, ?, ?)',
            <dynamic>[categoryID, params.name, params.color, params.alcohol]);
        if (beverageID < 1) throw ArgumentFailure();

        return <String, dynamic>{
          'alcohol': params.alcohol,
          'name': params.name,
          'totalDrinkCount': 0,
          'category': params.categoryName,
          'bevID': beverageID,
          'catID': categoryID,
          'color': params.color,
        };
      } on DatabaseException {
        throw ArgumentFailure();
      }
    });
    return BeverageModel.fromJson(result);
  }
}
