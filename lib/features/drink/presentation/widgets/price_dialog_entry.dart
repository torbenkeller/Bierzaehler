
import 'package:flutter/material.dart';

class PriceDialogEntry extends StatelessWidget {
  const PriceDialogEntry({
    @required this.value,
    @required this.menuValue,
    @required this.child,
  })  : assert(value != null),
        assert(menuValue != null),
        assert(child != null);

  final int value;
  final int menuValue;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 56,
          height: 48,
          child: value == menuValue
              ? Center(
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
              ))
              : Container(),
        ),
        child,
      ],
    );
  }
}
