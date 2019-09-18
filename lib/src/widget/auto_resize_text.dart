import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../themes/spacing/linear_scale.dart';

class AutoResizeText extends StatelessWidget {
  final String text;
  final Color textColor;
  final TextAlign textAlign;
  final double containerTextWidth;
  final Color containerTexColor;
  final double minFontSize;
  final int maxLines;
  final TextDecoration decoration;
  final double lineHeight;
  final double paddingTop;
  final double paddingLeft;
  final double paddingRight;
  final double paddingBottom;
  final BoxDecoration boxDecoration;

  const AutoResizeText({
    Key key,
    @required this.text,
    this.textColor = const Color(0xff3f3e3e),
    this.textAlign = TextAlign.center,
    this.containerTextWidth = 27.0,
    this.containerTexColor = const Color(0xffffffff),
    this.minFontSize = 12,
    this.maxLines = 1,
    this.decoration = TextDecoration.none,
    this.lineHeight = 1,
    this.paddingTop = 0.0,
    this.paddingLeft = 0.0,
    this.paddingRight = 0.0,
    this.paddingBottom = 0.0,
    this.boxDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: space_heliotrope,
      padding: EdgeInsets.only(
        top: paddingTop,
        left: paddingLeft,
        right: paddingRight,
        bottom: paddingBottom,
      ),
      decoration: boxDecoration != null
          ? boxDecoration
          : BoxDecoration(
              color: containerTexColor,
            ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: AutoSizeText(
              text,
              textAlign: textAlign,
              style: TextStyle(
                color: textColor,
                fontSize: space_golden_dream,
                decoration: decoration,
                height: lineHeight,
              ),
              minFontSize: minFontSize,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
