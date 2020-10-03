import 'package:bierzaehler/domain/drink/drink.dart';
import 'package:bierzaehler/domain/drink/i_drink_repository.dart';
import 'package:bierzaehler/infrastructure/drink/i_drink_local_data_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDrinkRepository)
class DrinkRepository implements IDrinkRepository {
  const DrinkRepository({@required this.localDataSource});

  final IDrinkLocalDataSource localDataSource;

  @override
  Future<List<Drink>> getAllDrinksForBeverage(GetAllDrinksForBeverageParams params) {
    return localDataSource.getAllDrinksForBeverage(params);
  }

  @override
  Future<Drink> createNewDrink(CreateNewDrinkParams params) {
    return localDataSource.createNewDrink(params);
  }
}
