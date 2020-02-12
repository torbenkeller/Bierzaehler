import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/data/models/beverage_model.dart';

abstract class BeverageLocalDataSource{

  /// Returns the Meta Data of all Beverages or a Failure.
  Future<List<BeverageModel>> getAllBeverages();

  /// Creates a new Beverage from params and returns the created Beverage.
  Future<BeverageModel> createNewBeverage(CreateBeverageParams params);

  /// Updates the parameters of the old beverage and returns the updated one.
  Future<BeverageModel> updateBeverage(UpdateBeverageParams params);
}