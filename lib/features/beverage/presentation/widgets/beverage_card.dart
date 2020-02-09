import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
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
      elevation: 6,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              beverage.name.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(fontWeight: FontWeight.w600),
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
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: beverage.color, shape: BoxShape.circle),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  beverage.totalDrinkCount.toString(),
                  style: Theme.of(context).textTheme.title,
                ),
                Icon(
                  MyFlutterApp.bier_icon,
                  size: 22,
                  color: Colors.black87,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}