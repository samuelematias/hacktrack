import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPress;
  final Color borderColor;
  final String label;
  final Color labelColor;
  final double width;
  final double height;
  final Color buttonColor;

  const Button({
    Key key,
    @required this.onPress,
    this.borderColor = const Color(0xffdcdcdc),
    this.label = '',
    this.labelColor = const Color(0xffea1d2c),
    this.width = 90.0,
    this.height = 40.0,
    this.buttonColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: width,
        height: height,
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
            style: TextStyle(
              color: labelColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
