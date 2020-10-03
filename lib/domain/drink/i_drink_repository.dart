import 'package:bierzaehler/domain/drink/drink.dart';
import 'package:meta/meta.dart';

abstract class IDrinkRepository {
  Future<List<Drink>> getAllDrinksForBeverage(GetAllDrinksForBeverageParams params);

  Future<Drink> createNewDrink(CreateNewDrinkParams params);
}

class GetAllDrinksForBeverageParams {
  const GetAllDrinksForBeverageParams({@required this.beverageID});

  final int beverageID;
}

class CreateNewDrinkParams {
  const CreateNewDrinkParams({
    @required this.size,
    @required this.price,
    @required this.beverageID,
  });

  final double size;
  final double price;
  final int beverageID;
}
