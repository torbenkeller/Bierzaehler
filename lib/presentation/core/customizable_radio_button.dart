import 'package:flutter/material.dart';

class ColorRadioButton extends StatelessWidget {
  const ColorRadioButton({
    @required this.colorNum,
    @required this.selectedColorNum,
    @required this.onChanged,
    Key key,
  })  : assert(colorNum != null),
        assert(selectedColorNum != null),
        assert(onChanged != null),
        super(key: key);

  final int colorNum;
  final int selectedColorNum;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(colorNum),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration:
                BoxDecoration(color: Color(colorNum), shape: BoxShape.circle),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 4),
          ),
          AnimatedContainer(
            height: 5,
            width: (colorNum == selectedColorNum) ? 30 : 0,
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
                color: Color(colorNum),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
          )
        ],
      ),
    );
  }
}
