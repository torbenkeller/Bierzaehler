import 'package:bierzaehler/features/beverage/presentation/manager/beverages_list_change_notifier.dart';
import 'package:bierzaehler/features/beverage/presentation/pages/beverages_page.dart';
import 'package:bierzaehler/injection_container.dart' as di;
import 'package:bierzaehler/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(BierzaehlerApp());
}

class BierzaehlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BeveragesListChangeNotifier>(
        create: (_) => sl<BeveragesListChangeNotifier>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BeveragesPage(),
        ));
  }
}
