import 'package:flutter/material.dart';

class H3 extends StatelessWidget {
  final String text;

  const H3({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline,
    );
  }
}
