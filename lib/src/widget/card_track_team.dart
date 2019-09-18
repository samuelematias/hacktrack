import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../themes/color_palette.dart';
import '../themes/spacing/linear_scale.dart';
import 'auto_resize_text.dart';
import 'card_shadow.dart';
import 'row_info.dart';

class CardTrackTeam extends StatelessWidget {
  final String photo;
  final String stage;
  final String status;
  final String updatedAt;
  final String about;
  final Color aboutColor;
  final bool isDashed;

  const CardTrackTeam({
    Key key,
    this.photo = '',
    this.stage = 'Problem',
    this.status = 'Need help',
    this.updatedAt = 'Updated 1h ago by Pedro Barcelar',
    this.about = 'The team is very confused on what defines a good problem.',
    this.aboutColor = const Color(0xff293845),
    this.isDashed = false,
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
                    icon: Icons.star,
                    iconColor: darkGrey,
                    circleColor: heavyGrey,
                    title: "Team Fire",
                    subTitle: "5 participants",
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
                      textColor: lightGrey,
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
                  textColor: red,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
