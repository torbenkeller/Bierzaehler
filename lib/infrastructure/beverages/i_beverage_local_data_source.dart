import 'package:bierzaehler/domain/beverages/i_beverage_repository.dart';
import 'package:bierzaehler/infrastructure/beverages/beverage_model.dart';

abstract class IBeverageLocalDataSource {
  /// Returns the Meta Data of all Beverages or a Failure.
  Future<List<BeverageModel>> getAllBeverages();

  /// Creates a new Beverage from params and returns the created Beverage.
  Future<BeverageModel> createNewBeverage(CreateBeverageParams params);

  /// Updates the parameters of the old beverage and returns the updated one.
  Future<BeverageModel> updateBeverage(UpdateBeverageParams params);
}
