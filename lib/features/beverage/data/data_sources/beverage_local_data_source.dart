import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';

abstract class BeverageLocalDataSource{

  /// Returns the Meta Data of all Beverages or a Failure.
  Future<List<Beverage>> getAllBeverages();
}