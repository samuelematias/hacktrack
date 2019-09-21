import 'package:flutter/material.dart';

import '../themes/color_palette.dart';
import '../themes/spacing/linear_scale.dart';

class ErrorAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: red,
      padding: EdgeInsets.all(space_dodger_blue),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Please, try again later.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.button,
          ),
        ],
      ),
    );
  }
}
