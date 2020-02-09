import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/create_new_beverage.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/get_all_beverages.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

enum LoadingStatus { loading, complete }

class BeveragesListChangeNotifier with ChangeNotifier {
  BeveragesListChangeNotifier(
      {@required GetAllBeverages getAllBeverages,
      @required CreateNewBeverage createNewBeverage})
      : _getAllBeverages = getAllBeverages,
        _createNewBeverage = createNewBeverage {
    syncBeverageList();
  }

  final GetAllBeverages _getAllBeverages;
  final CreateNewBeverage _createNewBeverage;

  Future<void> syncBeverageList() async {
    _setLoadingStatus(LoadingStatus.loading);
    _beverageList = await _getAllBeverages(NoParams());
    _setLoadingStatus(LoadingStatus.complete);
  }

  Future<bool> createNewBeverage(CreateBeverageParams params) async {
    final Beverage newBeverage =
        (await _createNewBeverage(params)).getOrElse(() => null);
    if (newBeverage == null) return false;
    final List<Beverage> currentList =
        _beverageList?.fold((_) => null, (List<Beverage> list) => list) ??
            <Beverage>[];
    _beverageList =
        Right<Failure, List<Beverage>>(currentList..add(newBeverage));
    return true;
  }

  Either<Failure, List<Beverage>> _beverageList;

  LoadingStatus _loadingStatus = LoadingStatus.loading;

  Either<Failure, List<Beverage>> get beverageList => _beverageList;

  LoadingStatus get loadingStatus => _loadingStatus;

  void _setLoadingStatus(LoadingStatus value) {
    _loadingStatus = value;
    notifyListeners();
  }
}
