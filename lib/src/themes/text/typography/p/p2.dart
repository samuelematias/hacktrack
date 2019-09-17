import 'package:flutter/material.dart';

class P2 extends StatelessWidget {
  final String text;

  const P2({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.body2,
    );
  }
}
