import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../themes/color_palette.dart';
import '../themes/spacing/linear_scale.dart';
import 'auto_resize_text.dart';
import 'card_shadow.dart';
import 'row_info.dart';

class CardTrackTeam extends StatelessWidget {
  final String stage;
  final String updatedAt;
  final Color updatedAtColor;
  final String about;
  final Color aboutColor;
  final bool isDashed;
  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final String teamName;
  final String teamCount;

  const CardTrackTeam({
    Key key,
    this.stage = '',
    this.updatedAt = '',
    this.updatedAtColor = const Color(0xffe8833a),
    this.about = '',
    this.aboutColor = const Color(0xff293845),
    this.isDashed = false,
    this.icon = Icons.group,
    this.iconColor = const Color(0xffefa544),
    this.circleColor = const Color(0xfff8dbb4),
    this.teamName = '',
    this.teamCount = '',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CardShadow(
      width: 300,
      child: DottedBorder(
        dashPattern: [6, 6, 6, 6],
        color: isDashed ? grey : Colors.transparent,
        strokeWidth: 1,
        child: Container(
          padding: EdgeInsets.only(
            top: space_golden_dream,
            bottom: space_golden_dream,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  bottom: space_spring_green,
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(color: grey, width: 2),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: space_dodger_blue,
                    right: space_dodger_blue,
                  ),
                  child: RowInfo(
                    icon: icon,
                    iconColor: iconColor,
                    circleColor: circleColor,
                    title: teamName,
                    subTitle: teamCount,
                    buttonLabel: "Open",
                    onPress: () {},
                    rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: space_golden_dream,
                  top: space_dodger_blue,
                  right: space_golden_dream,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AutoResizeText(
                      text: stage,
                      containerTextWidth: 80,
                    ),
                    AutoResizeText(
                      text: updatedAt,
                      containerTextWidth: 185,
                      textAlign: TextAlign.right,
                      textColor: updatedAtColor,
                      fontSize: space_dodger_blue,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: space_golden_dream,
                  top: space_golden_dream,
                  right: space_golden_dream,
                ),
                child: AutoResizeText(
                  text: about,
                  containerTextWidth: 300,
                  textAlign: TextAlign.left,
                  textColor: aboutColor,
                  maxLines: 3,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
