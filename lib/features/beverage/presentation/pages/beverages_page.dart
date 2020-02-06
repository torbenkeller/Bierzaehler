import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/presentation/manager/beverages_list_change_notifier.dart';
import 'package:bierzaehler/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeveragesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bierzähler'),
      ),
      body: ChangeNotifierProvider<BeveragesListChangeNotifier>(
        create: (_) => sl<BeveragesListChangeNotifier>(),
        child: Consumer<BeveragesListChangeNotifier>(
            builder: (_, BeveragesListChangeNotifier notifier, __) {
          switch (notifier.loadingStatus) {
            case LoadingStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LoadingStatus.complete:
              return notifier.beverageList.fold(
                  (Failure failure) => Center(
                        child: Text(failure.toString()),
                      ),
                  (List<Beverage> beverageList) => ListView.builder(
                      itemCount: beverageList.length,
                      itemBuilder: (_, int index) => ListTile(
                            title: Text(beverageList[index].name),
                          )));
            default:
              return null;
          }
        }),
      ),
    );
  }
}
