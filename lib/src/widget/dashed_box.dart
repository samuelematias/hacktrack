import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../themes/color_palette.dart';

class DashedBox extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const DashedBox({
    Key key,
    this.width = 60.0,
    this.height = 60.0,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [6, 6, 6, 6],
      color: grey,
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
