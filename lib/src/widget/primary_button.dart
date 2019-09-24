import 'package:flutter/material.dart';

import '../themes/color_palette.dart';
import '../themes/spacing/linear_scale.dart';
import 'custom_progress_indicator.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPress;
  final Color borderColor;
  final String label;
  final double width;
  final double height;
  final Color buttonColor;
  final Color labelColor;
  final String isDisable;
  final bool isLoading;

  const PrimaryButton({
    Key key,
    @required this.onPress,
    this.borderColor = const Color(0xff3071ff),
    this.label = '',
    this.width = 250.0,
    this.height = 40.0,
    this.buttonColor = const Color(0xff3071ff),
    this.labelColor = Colors.white,
    this.isDisable = "ok",
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisable == "ok" || isLoading ? onPress : () {},
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: isDisable == "ok" ? borderColor : regularGrey,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: isDisable == "ok" ? buttonColor : regularGrey,
        ),
        child: Center(
          child: isLoading
              ? CustomProgressIndicator()
              : Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: space_golden_dream,
                    color: labelColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
