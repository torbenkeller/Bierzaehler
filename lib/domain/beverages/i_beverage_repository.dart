import 'package:bierzaehler/domain/beverages/beverage.dart';
import 'package:meta/meta.dart';

abstract class IBeverageRepository {
  Future<List<Beverage>> getAllBeverages();

  Future<Beverage> createNewBeverage(CreateBeverageParams params);

  Future<Beverage> updateBeverage(UpdateBeverageParams params);
}

class CreateBeverageParams {
  const CreateBeverageParams({
    @required this.categoryName,
    @required this.name,
    @required this.color,
    @required this.alcohol,
  });

  final String categoryName;
  final String name;
  final int color;
  final double alcohol;
}

class UpdateBeverageParams {
  const UpdateBeverageParams({
    @required this.old,
    @required this.newCategoryName,
    @required this.newName,
    @required this.newColor,
    @required this.newAlcohol,
  });

  final Beverage old;
  final String newCategoryName;
  final String newName;
  final int newColor;
  final double newAlcohol;
}
