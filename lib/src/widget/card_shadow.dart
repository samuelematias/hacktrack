import 'package:flutter/material.dart';

import '../themes/color_palette.dart';

class CardShadow extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color cardColor;

  const CardShadow({
    Key key,
    this.width,
    this.height,
    this.child,
    this.cardColor = const Color(0xffffffff),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.06, 0.06],
          colors: [cardColor, cardColor],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadownGrey,
            spreadRadius: 1.0,
            blurRadius: 2.5,
            offset: Offset(0.0, 1.5),
          ),
        ],
      ),
      child: child,
    );
  }
}
