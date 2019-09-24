import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DashedBox extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color dasheColor;

  const DashedBox({
    Key key,
    this.width = 60.0,
    this.height = 60.0,
    this.child,
    this.dasheColor = const Color(0xffc3cfd9),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [6, 6, 6, 6],
      color: dasheColor,
      strokeWidth: 2,
      child: Container(
        color: Colors.transparent,
        width: width,
        height: height,
        child: child == null ? Container() : child,
      ),
    );
  }
}
