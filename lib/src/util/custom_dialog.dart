import 'package:flutter/material.dart';

import '../themes/spacing/linear_scale.dart';

class CustomDialog {
  static show(BuildContext context, Widget content, double dialogHeight) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
            children: <Widget>[
              Container(
                height: dialogHeight != null ? dialogHeight : space_magic_mint,
                child: Column(
                  children: <Widget>[
                    content,
                  ],
                ),
              ),
            ],
          );
        });
  }
}
