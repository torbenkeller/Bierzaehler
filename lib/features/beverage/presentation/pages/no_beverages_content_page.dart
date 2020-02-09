import 'package:flutter/material.dart';

class NoBeveragesContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text('Keine Getränke vorhanden'),
        Text('Erstelle jetzt dein erstes Getränk!'),
      ]),
    );
  }
}
