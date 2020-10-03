import 'package:flutter/material.dart';

class NoBeveragesContentPage extends StatelessWidget {
  //TODO: implement better design
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Align(
        alignment: Alignment.topRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.arrow_upward,
              size: 48,
              color: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Hier kannst du ein\nneues Getränk erstellen!',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text('Noch keine Getränke vorhanden'),
            Text('Erstelle jetzt dein erstes Getränk!'),
          ],
        ),
      ),
    ]);
  }
}
