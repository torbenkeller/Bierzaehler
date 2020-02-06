import 'package:bierzaehler/features/beverage/presentation/pages/beverages_page.dart';
import 'package:bierzaehler/injection_container.dart' as di;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(BierzaehlerApp());
}

class BierzaehlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BeveragesPage(),
    );
  }
}
