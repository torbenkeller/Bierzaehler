import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:bierzaehler/features/drink/domain/use_cases/get_all_drinks_for_beverage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

enum LoadingStatus { loading, complete }

class DrinkListChangeNotifier with ChangeNotifier {
  DrinkListChangeNotifier(
      {@required GetAllDrinksForBeverage getAllDrinksForBeverage})
      : _getAllDrinksForBeverage = getAllDrinksForBeverage;

  final GetAllDrinksForBeverage _getAllDrinksForBeverage;
  Either<Failure, List<Drink>> _drinksList;
  LoadingStatus _loadingStatus;

  Future<void> syncDrinksList({@required int beverageID}) async {
    _setLoadingStatus(LoadingStatus.loading);
    _drinksList = await _getAllDrinksForBeverage(
        GetAllDrinksForBeverageParams(beverageID: beverageID));
    _setLoadingStatus(LoadingStatus.complete);
  }

  void _setLoadingStatus(LoadingStatus value) {
    _loadingStatus = value;
    notifyListeners();
  }

  LoadingStatus get loadingStatus => _loadingStatus;

  Either<Failure, List<Drink>> get drinksList => _drinksList;
}
