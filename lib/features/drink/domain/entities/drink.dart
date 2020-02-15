import 'package:bierzaehler/features/drink/domain/entities/price.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Drink extends Equatable {
  const Drink({
    @required this.drinkID,
    @required this.prices,
    @required this.size,
  });

  final int drinkID;
  final List<Price> prices;
  final double size;

  @override
  List<Object> get props => <Object>[drinkID, prices, size];

}
