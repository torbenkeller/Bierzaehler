import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/beverage/data/data_sources/beverage_local_data_source.dart';
import 'package:bierzaehler/features/beverage/data/models/beverage_model.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

class BeverageLocalDataSourceImpl implements BeverageLocalDataSource {
  const BeverageLocalDataSourceImpl({@required this.database});

  final Database database;

  @override
  Future<List<Beverage>> getAllBeverages() async {
    List<Map<String, dynamic>> result;
    try {
      result = await database.rawQuery(
          'SELECT B.*, C.name as category, Sum(D.Size) as totalDrinkAmount,'
          ' Count(U.UseID) totalDrinkCount'
          ' FROM Category C join Beverage B using(CatID)'
          ' join Drink D USING(BevID) join Price P using(DriID)'
          ' join Use U using(PriID)'
          ' GROUP BY B.BevID;');
    } on DatabaseException {
      throw SqlFailure();
    }
    if (result.isEmpty) throw NoDataFailure();
    return result
        .map((Map<String, dynamic> data) => BeverageModel.fromJson(data))
        .toList();
  }
}
