import 'package:flutter/material.dart';

class P5 extends StatelessWidget {
  final String text;

  const P5({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.body1,
    );
  }
}
