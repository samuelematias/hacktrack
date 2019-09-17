import 'package:flutter/material.dart';

class GenericTextTheme extends TextTheme {
  GenericTextTheme()
      : super(
          headline: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          title: TextStyle(
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
          ),
          body1: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
          ),
        );
}
