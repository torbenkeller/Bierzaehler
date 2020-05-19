import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:bierzaehler/features/drink/domain/entities/price.dart';
import 'package:bierzaehler/features/drink/presentation/widgets/price_dialog_add_entry.dart';
import 'package:bierzaehler/features/drink/presentation/widgets/price_dialog_entry.dart';
import 'package:flutter/material.dart';

class PriceChangeDialogRoute extends PageRoute<int> {
  PriceChangeDialogRoute({
    @required this.drink,
    @required this.selectedPrice,
    @required this.position,
    @required this.theme,
    RouteSettings settings,
  })  : assert(drink != null),
        assert(selectedPrice != null),
        assert(position != null),
        assert(theme != null),
        super(settings: settings, fullscreenDialog: false);

  final Drink drink;
  final Price selectedPrice;
  final Size position;
  final ThemeData theme;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final double globalHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final double menuHeight = (72 + 48 * drink.prices.length).toDouble();
    double relativeFromTop = position.height;
    if ((relativeFromTop + menuHeight) > (globalHeight - keyboardHeight)) {
      relativeFromTop = globalHeight - keyboardHeight - menuHeight;
    }
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(animation),
              child: Container(
                constraints:const  BoxConstraints.expand(),
                color: Colors.black26,
              ),
            ),
            Container(
              constraints: const BoxConstraints.expand(),
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                  top: relativeFromTop,
                  left: position.width,
                ),
                child: Theme(
                  data: theme,
                  child: SizeTransition(
                    sizeFactor:
                    Tween<double>(begin: 0, end: 1).animate(animation),
                    child: Container(
                      width: 280,
                      height: menuHeight,
                      child: Card(
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              if (drink.prices.length > 5)
                                Container(
                                  height: 240,
                                  child: SingleChildScrollView(
                                    child: _buildPrices(),
                                  ),
                                )
                              else
                                _buildPrices(),
                              PriceDialogAddEntry(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String priceToFancyString(Price p) =>
      '${p.price.toStringAsFixed(2).replaceAll('.', ',')}€';

  Widget _buildPrices() => Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      for (Price price in drink.prices)
        PriceDialogEntry(
          value: price.priceID,
          menuValue: selectedPrice.priceID,
          child: Text(priceToFancyString(price)),
        ),
    ],
  );
}
