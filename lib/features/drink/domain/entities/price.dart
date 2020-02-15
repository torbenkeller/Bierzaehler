import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Price extends Equatable {
  const Price({
    @required this.priceID,
    @required this.price,
  });

  final int priceID;
  final double price;

  @override
  List<Object> get props => <Object>[priceID, price];
}
