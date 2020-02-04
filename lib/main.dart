import 'package:flutter/material.dart';

void main() => runApp(BierzaehlerApp());

class BierzaehlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Bierzähler App!'),
        ),
      ),
    );
  }
}
