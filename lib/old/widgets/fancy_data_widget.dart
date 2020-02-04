import 'package:flutter/material.dart';

class FancyDataWidget extends StatelessWidget {
  final Color color;
  final Widget content;
  final Widget description;

  FancyDataWidget({@required this.color, @required this.content, @required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 96.0,
          height: 96.0,
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    offset: Offset(2.0, 2.0))
              ]),
          child: Center(
            child: content,
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4.0),),
        Center(
            child: description
        ),
      ],
    );
  }
}
