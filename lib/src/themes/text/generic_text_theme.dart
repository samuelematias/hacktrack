import 'package:flutter/material.dart';

import '../color_palette.dart';
import '../spacing/linear_scale.dart';

class GenericTextTheme extends TextTheme {
  GenericTextTheme()
      : super(
          title: TextStyle(
            fontSize: space_fire_bush,
            fontWeight: FontWeight.bold,
          ),
          body1: TextStyle(
            fontSize: space_dodger_blue,
            fontWeight: FontWeight.w600,
          ),
          button: TextStyle(
            fontSize: space_golden_dream,
            color: white,
            fontWeight: FontWeight.w600,
          ),
        );
}
