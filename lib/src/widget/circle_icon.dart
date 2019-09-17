import 'package:flutter/material.dart';

import '../themes/spacing/linear_scale.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color circleColor;

  const CircleIcon({
    Key key,
    @required this.icon,
    this.iconColor = Colors.white,
    this.circleColor = const Color(0xffea1d2c),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: space_conifer,
                  height: space_conifer,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 12.0,
                top: 12.0,
                child: Center(
                  child: Container(
                    // color: red,
                    child: Icon(
                      icon,
                      color: iconColor,
                      // size: space_magic_mint,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
