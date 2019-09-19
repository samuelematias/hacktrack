import 'package:flutter/material.dart';

class P4 extends StatelessWidget {
  final String text;

  const P4({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).accentTextTheme.body1,
    );
  }
}
