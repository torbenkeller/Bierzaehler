import 'package:bierzaehler/domain/drink/price.dart';
import 'package:flutter/foundation.dart';

class Drink {
  const Drink({
    @required this.drinkID,
    @required this.prices,
    @required this.size,
  });

  final int drinkID;
  final List<Price> prices;
  final double size;
}
