import 'package:flutter/material.dart';

import '../color_palette.dart';
import '../spacing/linear_scale.dart';

class AccentTextTheme extends TextTheme {
  AccentTextTheme()
      : super(
          title: TextStyle(
            fontSize: space_golden_dream,
            color: black,
            fontWeight: FontWeight.w600,
          ),
          headline: TextStyle(
            fontSize: space_fire_bush,
            color: black,
            fontWeight: FontWeight.w600,
          ),
          button: TextStyle(
            fontSize: space_golden_dream,
            color: purple,
            fontWeight: FontWeight.w600,
          ),
        );
}
