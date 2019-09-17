import 'package:flutter/material.dart';

import '../themes/spacing/linear_scale.dart';
import '../themes/text/typography/h/h2.dart';
import '../themes/text/typography/p/p1.dart';
import 'circle_icon.dart';
import 'primary_button.dart';
import 'secondary_button.dart';

class RowInfo extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final String title;
  final String subTitle;
  final String buttonLabel;
  final bool isSecondaryButton;
  final Function onPress;

  const RowInfo({
    Key key,
    @required this.icon,
    @required this.onPress,
    this.iconColor = Colors.white,
    this.circleColor = const Color(0xffea1d2c),
    this.title = '',
    this.subTitle = '',
    this.buttonLabel = '',
    this.isSecondaryButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleIcon(
                    icon: icon,
                    iconColor: iconColor,
                    circleColor: circleColor,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: space_dodger_blue,
                        ),
                        child: H2(
                          text: title,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: space_dodger_blue,
                          top: space_carmine,
                        ),
                        child: P1(
                          text: subTitle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              isSecondaryButton
                  ? SecondaryButton(
                      label: buttonLabel,
                      onPress: onPress,
                      width: 100,
                    )
                  : PrimaryButton(
                      label: buttonLabel,
                      onPress: onPress,
                      width: 100,
                    ),
            ],
          ),
        )
      ],
    );
  }
}