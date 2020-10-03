import 'package:bierzaehler/application/drink/drink_list_cange_notifier.dart';
import 'package:bierzaehler/domain/beverages/beverage.dart';
import 'package:bierzaehler/injection.dart';
import 'package:bierzaehler/presentation/drink/drink_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DropdownAction { createDrink, undoDrinking }

class BeveragePage extends StatefulWidget {
  const BeveragePage({Key key, this.beverage}) : super(key: key);

  final Beverage beverage;

  @override
  _BeveragePageState createState() => _BeveragePageState();
}

class _BeveragePageState extends State<BeveragePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerSize;
  TextEditingController _controllerPrice;

  @override
  void initState() {
    super.initState();
    _controllerSize = TextEditingController(text: '0');
    _controllerPrice = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerSize.dispose();
    _controllerPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: widget.beverage.color),
      child: ChangeNotifierProvider<DrinkListChangeNotifier>(
        create: (_) {
          final DrinkListChangeNotifier notifier = getIt<DrinkListChangeNotifier>();
          notifier.syncDrinksList(beverageID: widget.beverage.beverageID);
          return notifier;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.beverage.name),
              actions: <Widget>[
                Consumer<DrinkListChangeNotifier>(
                  builder: (BuildContext context, DrinkListChangeNotifier notifier, _) =>
                      PopupMenuButton<DropdownAction>(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<DropdownAction>>[
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
                    onSelected: (DropdownAction action) {
                      switch (action) {
                        case DropdownAction.createDrink:
                          _showCreateDrinkDialog(context, notifier);
                          break;
                        case DropdownAction.undoDrinking:
                          // TODO: Handle this case.
                          break;
                      }
                    },
                  ),
                )
              ],
            ),
            body: Consumer<DrinkListChangeNotifier>(
              builder: (BuildContext context, DrinkListChangeNotifier notifier, _) {
                switch (notifier.loadingStatus) {
                  case LoadingStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case LoadingStatus.complete:
                    if (notifier.drinksList == null) {
                      return const Center(
                        child: Text('Noch keine Gläser vorhanden'),
                      );
                    }
                    return ListView.builder(
                      itemCount: notifier.drinksList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Center(child: DrinkCard(drink: notifier.drinksList[index])),
                    );
                }
                return null;
              },
            )),
      ),
    );
  }

  void _showCreateDrinkDialog(BuildContext context, DrinkListChangeNotifier notifier) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Glas hinzufügen',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                          ),
                          TextFormField(
                            controller: _controllerSize,
                            decoration:
                                const InputDecoration(hintText: 'Größe', labelText: 'Größe'),
                            autofocus: true,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (String value) {
                              if (value.isEmpty) return 'Pflichtfeld';
                              try {
                                final String valueFormatted = value.replaceAll(',', '.');
                                final double size = double.parse(valueFormatted);
                                if (size <= 0) {
                                  return 'Solch ein Glas gibt es nicht!';
                                }
                                return null;
                              } catch (e) {
                                return 'Bitte gib eine Zahl ein!';
                              }
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                          ),
                          TextFormField(
                            controller: _controllerPrice,
                            decoration:
                                const InputDecoration(hintText: 'Preis', labelText: 'Preis in €'),
                            autofocus: false,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            validator: (String value) {
                              if (value.isEmpty) return 'Pflichtfeld';
                              try {
                                final String valueFormatted = value.replaceAll(',', '.');
                                final double price = double.parse(valueFormatted);
                                if (price < 0) {
                                  return 'Fürs trinken gibt leider kein Geld';
                                }

                                return null;
                              } catch (e) {
                                return 'Bitte gib eine Zahl ein!';
                              }
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                textColor: Theme.of(context).primaryColor,
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Abbrechen'),
                              ),
                              RaisedButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    final String sizeFormatted =
                                        _controllerSize.text.replaceAll(',', '.');
                                    final double size = double.parse(sizeFormatted);
                                    final String priceFormatted =
                                        _controllerPrice.text.replaceAll(',', '.');
                                    final double price = double.parse(priceFormatted);
                                    notifier.createNewDrink(
                                        size: size,
                                        price: price,
                                        beverageID: widget.beverage.beverageID);
                                    _controllerPrice.text = '0';
                                    _controllerSize.text = '';
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text('Ok'),
                              ),
                            ],
                          )
                        ],
                      )))),
            ));
  }
}
