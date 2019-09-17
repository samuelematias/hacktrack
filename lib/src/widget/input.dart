import 'package:flutter/material.dart';

import '../themes/color_palette.dart';

class Input extends TextField {
  Input({
    @required BuildContext context,
    String hint,
    FocusNode focusNode,
    TextEditingController inputController,
    bool autofocus = false,
  }) : super(
          // key: Key("email"),
          focusNode: focusNode,
          controller: inputController,
          onChanged: (text) {},
          autofocus: autofocus,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          style: TextStyle(
            color: black,
          ),
          decoration: InputDecoration(
            labelText: hint,
            labelStyle: TextStyle(color: black),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: purple, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: black, width: 1.0),
            ),
            fillColor: black,
          ),
        );
}
