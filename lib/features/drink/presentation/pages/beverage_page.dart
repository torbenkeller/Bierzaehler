import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/drink/domain/entities/drink.dart';
import 'package:bierzaehler/features/drink/presentation/manager/drink_list_cange_notifier.dart';
import 'package:bierzaehler/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DropdownAction { createDrink, undoDrinking }

class BeveragePage extends StatelessWidget {
  const BeveragePage({Key key, this.beverage}) : super(key: key);

  final Beverage beverage;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: beverage.color),
      child: Scaffold(
        appBar: AppBar(
          title: Text(beverage.name),
          actions: <Widget>[
            PopupMenuButton<DropdownAction>(
              icon: Icon(Icons.more),
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<DropdownAction>>[
                PopupMenuItem<DropdownAction>(
                  value: DropdownAction.createDrink,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 32,
                        alignment: Alignment.centerLeft,
                        child: const Icon(
                          Icons.add,
                          color: Colors.black87,
                        ),
                      ),
                      const Text('Neues Glas'),
                    ],
                  ),
                ),
                PopupMenuItem<DropdownAction>(
                  value: DropdownAction.undoDrinking,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: 32,
                        alignment: Alignment.centerLeft,
                        child: const Icon(
                          Icons.undo,
                          color: Colors.black87,
                        ),
                      ),
                      const Text('Trinken Rückgängig'),
                    ],
                  ),
                ),
              ],
              onSelected: (DropdownAction action){
                switch(action){
                  case DropdownAction.createDrink:
                    //TODO: implement create drink
                    break;
                  case DropdownAction.undoDrinking:
                    // TODO: Handle this case.
                    break;
                }
              },
            )
          ],
        ),
        body: ChangeNotifierProvider<DrinkListChangeNotifier>(create: (_) {
          final DrinkListChangeNotifier notifier =
              sl<DrinkListChangeNotifier>();
          notifier.syncDrinksList(beverageID: beverage.beverageID);
          return notifier;
        }, child: Consumer<DrinkListChangeNotifier>(
          builder: (BuildContext context, DrinkListChangeNotifier notifier, _) {
            switch (notifier.loadingStatus) {
              case LoadingStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case LoadingStatus.complete:
                return notifier.drinksList.fold<Widget>(
                  (Failure f) {
                    if (f is NoDataFailure) {
                      return const Center(
                        child: Text('Noch keine Gläser vorhanden'),
                      );
                    } else {
                      return const Center(
                        child: Text(
                            'Ups! Es ist ein Fehler beim Laden aufgetreten'),
                      );
                    }
                  },
                  (List<Drink> drinks) => ListView.builder(
                    itemCount: drinks.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(
                          '${drinks[index].size.toStringAsFixed(2).replaceAll('.', ',')}l'),
                    ),
                  ),
                );
            }
            return null;
          },
        )),
      ),
    );
  }
}
