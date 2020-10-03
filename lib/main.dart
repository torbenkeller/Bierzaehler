import 'package:bierzaehler/application/beverages/beverages_list_change_notifier.dart';
import 'package:bierzaehler/injection.dart';
import 'package:bierzaehler/presentation/beverages/beverages_page.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.prod);
  runApp(BierzaehlerApp());
}

class BierzaehlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BeveragesListChangeNotifier>(
        create: (_) => getIt<BeveragesListChangeNotifier>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BeveragesPage(),
        ));
  }
}
