import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:bierzaehler/features/drink/domain/use_cases/create_new_drink.dart';
import 'package:bierzaehler/features/drink/domain/use_cases/get_all_drinks_for_beverage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

enum LoadingStatus { loading, complete }

class DrinkListChangeNotifier with ChangeNotifier {
  DrinkListChangeNotifier({
    @required GetAllDrinksForBeverage getAllDrinksForBeverage,
    @required CreateNewDrink createNewDrink,
  })  : _getAllDrinksForBeverage = getAllDrinksForBeverage,
        _createNewDrink = createNewDrink;

  final GetAllDrinksForBeverage _getAllDrinksForBeverage;
  final CreateNewDrink _createNewDrink;
  Either<Failure, List<Drink>> _drinksList;
  LoadingStatus _loadingStatus;

  Future<void> syncDrinksList({@required int beverageID}) async {
    _setLoadingStatus(LoadingStatus.loading);
    _drinksList = await _getAllDrinksForBeverage(
        GetAllDrinksForBeverageParams(beverageID: beverageID));
    _setLoadingStatus(LoadingStatus.complete);
  }

  Future<bool> createNewDrink({
    @required double size,
    @required double price,
    @required int beverageID,
  }) async {
    final Drink newDrink = (await _createNewDrink(CreateNewDrinkParams(
            price: price, size: size, beverageID: beverageID)))
        .getOrElse(() => null);
    if (newDrink == null) return false;

    final List<Drink> currentList =
        _drinksList?.fold((_) => null, (List<Drink> list) => list) ?? <Drink>[];
    _drinksList = Right<Failure, List<Drink>>(
        List<Drink>.from(currentList)..add(newDrink));
    notifyListeners();
    return true;
  }

  void _setLoadingStatus(LoadingStatus value) {
    _loadingStatus = value;
    notifyListeners();
  }

  LoadingStatus get loadingStatus => _loadingStatus;

  Either<Failure, List<Drink>> get drinksList => _drinksList;
}
