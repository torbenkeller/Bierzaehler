import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/get_all_beverages.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

enum LoadingStatus { loading, complete }

class BeveragesListChangeNotifier with ChangeNotifier {
  BeveragesListChangeNotifier({@required this.getAllBeverages}) {
    _getBeverageList();
  }

  final GetAllBeverages getAllBeverages;

  Future<void> _getBeverageList() async {
    _setLoadingStatus(LoadingStatus.loading);
    _beverageList = await getAllBeverages(NoParams());
    _setLoadingStatus(LoadingStatus.complete);
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
