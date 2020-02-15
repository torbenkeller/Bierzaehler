import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/data/data_sources/drink_local_data_source.dart';
import 'package:bierzaehler/features/drink/data/models/drink_model.dart';
import 'package:sqflite/sqlite_api.dart';

class DrinkLocalDataSourceImpl implements DrinkLocalDataSource {
  const DrinkLocalDataSourceImpl(this.database);

  final Database database;

  @override
  Future<List<DrinkModel>> getAllDrinksForBeverage(
      GetAllDrinksForBeverageParams params) async {
    try {
      final List<Map<String, dynamic>> result =
          await database.transaction((Transaction txn) async {
        List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
        final List<Map<String, dynamic>> drinks = await txn.rawQuery(
            'select * from drink where bevID = ?', <int>[params.beverageID]);

        if (drinks.isEmpty) throw NoDataFailure();
        for (final Map<String, dynamic> drink in drinks) {
          final Map<String, dynamic> resultDrink =
              Map<String, dynamic>.from(drink);
          final List<Map<String, dynamic>> prices = await txn.rawQuery(
              'select * from Price where driID = ?',
              <int>[drink['driID'] as int]);

          resultDrink['prices'] = prices;
          result.add(resultDrink);
        }
        print(result);
        return result;
      });
      return result
          .map<DrinkModel>(
              (Map<String, dynamic> json) => DrinkModel.fromJson(json))
          .toList(growable: false);
    } on DatabaseException {
      throw SqlFailure();
    }
  }
}
