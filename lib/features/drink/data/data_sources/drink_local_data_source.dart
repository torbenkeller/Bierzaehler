import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/drink/data/models/drink_model.dart';

abstract class DrinkLocalDataSource {
  Future<List<DrinkModel>> getAllDrinksForBeverage(
      GetAllDrinksForBeverageParams params);
}
