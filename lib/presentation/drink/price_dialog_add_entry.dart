
import 'package:flutter/material.dart';

class PriceDialogAddEntry extends StatefulWidget {
  @override
  PriceDialogAddEntryState createState() => PriceDialogAddEntryState();
}

class PriceDialogAddEntryState extends State<PriceDialogAddEntry> {
  TextEditingController _controller;
  FocusNode _focusNode;
  bool _onFocus = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {
      _onFocus = true;
    }));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 280,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: const TextInputType.numberWithOptions(
                decimal: true, signed: false),
            decoration: InputDecoration(
                hintText: 'Neuer Preis',
                suffixText: '€',
                border: InputBorder.none,
                icon: Icon(Icons.add_circle_outline),
                suffixIcon: _onFocus
                    ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () => Navigator.pop<int>(context, -1),
                )
                    : null),
          ),
        ));
  }
}
