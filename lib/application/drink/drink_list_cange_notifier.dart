import 'package:bierzaehler/domain/drink/drink.dart';
import 'package:bierzaehler/domain/drink/i_drink_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

enum LoadingStatus { loading, complete }

@Injectable()
class DrinkListChangeNotifier with ChangeNotifier {
  DrinkListChangeNotifier(this._drinkRepository);

  final IDrinkRepository _drinkRepository;
  List<Drink> _drinksList;
  LoadingStatus _loadingStatus;

  Future<void> syncDrinksList({@required int beverageID}) async {
    _setLoadingStatus(LoadingStatus.loading);
    try {
      _drinksList = await _drinkRepository
          .getAllDrinksForBeverage(GetAllDrinksForBeverageParams(beverageID: beverageID));
    } catch (e) {}
    _setLoadingStatus(LoadingStatus.complete);
  }

  Future<bool> createNewDrink({
    @required double size,
    @required double price,
    @required int beverageID,
  }) async {
    final Drink newDrink = await _drinkRepository
        .createNewDrink(CreateNewDrinkParams(price: price, size: size, beverageID: beverageID));

    if (newDrink == null) return false;
    _drinksList.add(newDrink);
    notifyListeners();
    return true;
  }

  void _setLoadingStatus(LoadingStatus value) {
    _loadingStatus = value;
    notifyListeners();
  }

  LoadingStatus get loadingStatus => _loadingStatus;

  List<Drink> get drinksList => List.unmodifiable(_drinksList ?? []);
}
