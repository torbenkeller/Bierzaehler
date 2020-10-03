import 'package:bierzaehler/domain/drink/i_drink_repository.dart';
import 'package:bierzaehler/infrastructure/drink/drink_model.dart';

abstract class IDrinkLocalDataSource {
  Future<List<DrinkModel>> getAllDrinksForBeverage(GetAllDrinksForBeverageParams params);

  Future<DrinkModel> createNewDrink(CreateNewDrinkParams params);
}
