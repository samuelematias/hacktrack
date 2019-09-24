import 'package:flutter/material.dart';

import '../themes/color_palette.dart';

class CustomProgressIndicator extends SizedBox {
  CustomProgressIndicator({
    double width = 30.0,
    double height = 30.0,
    double strokeWidth = 2.0,
    Color bg = Colors.white,
  }) : super(
          child: CircularProgressIndicator(
            backgroundColor: bg,
            valueColor: AlwaysStoppedAnimation<Color>(purple),
            strokeWidth: strokeWidth,
          ),
          width: width,
          height: height,
        );
}
