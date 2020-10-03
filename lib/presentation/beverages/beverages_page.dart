import 'package:bierzaehler/application/beverages/beverages_list_change_notifier.dart';
import 'package:bierzaehler/presentation/beverages/create_new_beverage_page.dart';
import 'package:bierzaehler/presentation/beverages/info_page.dart';
import 'package:bierzaehler/presentation/beverages/lists_page.dart';
import 'package:bierzaehler/presentation/beverages/no_beverages_content_page.dart';
import 'package:bierzaehler/presentation/core/beverage_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DropdownAction { newBeverage, lists, info }

class BeveragesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BeveragesListChangeNotifier notifier = Provider.of<BeveragesListChangeNotifier>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Bierzähler'),
          actions: <Widget>[
            PopupMenuButton<DropdownAction>(
                icon: Icon(Icons.more_vert),
                itemBuilder: (_) => <PopupMenuEntry<DropdownAction>>[
                      PopupMenuItem<DropdownAction>(
                        value: DropdownAction.newBeverage,
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
                            const Text('Neues Getränk')
                          ],
                        ),
                      ),
                      PopupMenuItem<DropdownAction>(
                        value: DropdownAction.lists,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 32,
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.list,
                                color: Colors.black87,
                              ),
                            ),
                            const Text('Listen')
                          ],
                        ),
                      ),
                      PopupMenuItem<DropdownAction>(
                        value: DropdownAction.info,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 32,
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.info_outline,
                                color: Colors.black87,
                              ),
                            ),
                            const Text('Info')
                          ],
                        ),
                      ),
                    ],
                onSelected: (DropdownAction action) {
                  switch (action) {
                    case DropdownAction.newBeverage:
                      Navigator.of(context).push(MaterialPageRoute<Widget>(
                          fullscreenDialog: true,
                          maintainState: false,
                          builder: (BuildContext context) => CreateNewBeveragePage()));
                      break;
                    case DropdownAction.lists:
                      Navigator.of(context).push(MaterialPageRoute<Widget>(
                          fullscreenDialog: true,
                          maintainState: false,
                          builder: (BuildContext context) => ListsPage()));
                      break;
                    case DropdownAction.info:
                      Navigator.of(context).push(MaterialPageRoute<Widget>(
                          fullscreenDialog: true,
                          maintainState: false,
                          builder: (BuildContext context) => InfoPage()));
                      break;
                  }
                }),
          ],
        ),
        body: _buildPageContent(notifier, context));
  }

  Widget _buildPageContent(BeveragesListChangeNotifier notifier, BuildContext context) {
    switch (notifier.loadingStatus) {
      case LoadingStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case LoadingStatus.complete:
        return notifier.beverageList == null
            ? NoBeveragesContentPage()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: notifier.beverageList.length,
                itemBuilder: (_, int index) => BeverageCard(beverage: notifier.beverageList[index]),
              );
      default:
        return null;
    }
  }
}
