import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/data/data_sources/drink_local_data_source.dart';
import 'package:bierzaehler/features/drink/data/models/drink_model.dart';
import 'package:bierzaehler/features/drink/data/models/price_model.dart';
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

  @override
  Future<DrinkModel> createNewDrink(CreateNewDrinkParams params) async {
    try {
      Map<String, dynamic> newDrink =
          await database.transaction((Transaction txn) async {
        final int drinkID = await txn.rawInsert(
            'insert into drink (bevID, size) values (?,?)',
            <dynamic>[params.beverageID, params.size]);
        if (drinkID < 0) throw SqlFailure();
        final int priceID = await txn.rawInsert(
            'insert into price (driID, price) values (?,?)',
            <Object>[drinkID, params.price]);
        if (priceID < 0) throw SqlFailure();

        return <String, dynamic>{
          'driID': drinkID,
          'size': params.size,
          'prices': <Map<String, dynamic>>[
            <String, dynamic>{
              'priID': priceID,
              'price': params.price,
            },
          ],
        };
      });
      return DrinkModel.fromJson(newDrink);
    } on DatabaseException {
      throw SqlFailure();
    }
  }
}
