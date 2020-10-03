import 'package:bierzaehler/domain/beverages/beverage.dart';
import 'package:bierzaehler/presentation/beverages/create_new_beverage_page.dart';
import 'package:bierzaehler/presentation/drink/beverage_page.dart';
import 'package:bierzaehler/old/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class BeverageCard extends StatelessWidget {
  const BeverageCard({
    @required this.beverage,
    Key key,
  }) : super(key: key);

  final Beverage beverage;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => BeveragePage(
                  beverage: beverage,
                ))),
        onLongPress: () => Navigator.of(context).push(MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (_) => CreateNewBeveragePage(
                  toUpdate: beverage,
                ))),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                beverage.name.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
              ),
              Text(beverage.category.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: beverage.color)),
              Text('${(beverage.alcohol * 100).toStringAsFixed(1)}% vol. alc.',
                  style: Theme.of(context).textTheme.caption),
              Expanded(
                child: Container(),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    MyFlutterApp.bier_icon,
                    size: 22,
                    color: Colors.black87,
                  ),
                  Text(
                    beverage.totalDrinkCount.toString(),
                    style: Theme.of(context).textTheme.title,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: beverage.color, shape: BoxShape.circle),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
