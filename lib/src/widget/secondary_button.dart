import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final Function onPress;
  final Color borderColor;
  final String label;
  final double width;
  final double height;
  final Color buttonColor;

  const SecondaryButton(
      {Key key,
      @required this.onPress,
      this.borderColor = const Color(0xffc7c3fa),
      this.label = '',
      this.width = 90.0,
      this.height = 40.0,
      this.buttonColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 250.0,
        height: 40.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).accentTextTheme.button,
          ),
        ),
      ),
    );
  }
}
