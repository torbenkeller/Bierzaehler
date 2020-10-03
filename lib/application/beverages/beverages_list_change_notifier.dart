import 'package:bierzaehler/domain/beverages/beverage.dart';
import 'package:bierzaehler/domain/beverages/i_beverage_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

enum LoadingStatus { loading, complete }

@Injectable()
class BeveragesListChangeNotifier with ChangeNotifier {
  BeveragesListChangeNotifier(this._beverageRepository) {
    syncBeverageList();
  }

  final IBeverageRepository _beverageRepository;

  Future<void> syncBeverageList() async {
    _setLoadingStatus(LoadingStatus.loading);
    try {
      _beverageList = await _beverageRepository.getAllBeverages();
    } catch (e) {}
    _setLoadingStatus(LoadingStatus.complete);
  }

  Future<bool> createNewBeverage(CreateBeverageParams params) async {
    try {
      final Beverage newBeverage = await _beverageRepository.createNewBeverage(params);
      _beverageList.add(newBeverage);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBeverage(UpdateBeverageParams params) async {
    try {
      final Beverage result = await _beverageRepository.updateBeverage(params);
      final int updateListIndex =
          _beverageList.indexWhere((Beverage b) => b.beverageID == result.beverageID);
      final List<Beverage> newList = List<Beverage>.from(_beverageList);
      newList[updateListIndex] = result;
      _beverageList = List.unmodifiable(newList);
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  List<Beverage> _beverageList;

  LoadingStatus _loadingStatus = LoadingStatus.loading;

  List<Beverage> get beverageList => List.unmodifiable(_beverageList ?? []);

  LoadingStatus get loadingStatus => _loadingStatus;

  void _setLoadingStatus(LoadingStatus value) {
    _loadingStatus = value;
    notifyListeners();
  }
}
