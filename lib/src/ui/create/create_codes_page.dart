import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../util/metrics.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_button.dart';
import '../../widget/row_info.dart';

class CreateCodesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PrimaryAppBar(
        context: context,
        onClickBackButton: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
        },
      ),
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    double leftOverFlow = 20.0;
    double rightOverFlow = 20.0;
    double bottomOverFlow = 20.0;
    bool wrongId = false;
    String _subTitle1 = "shawee-mentor-A2C7";
    String _subTitle2 = "shawee-partic-PI2C";

    return SafeArea(
      child: Container(
        width: Metrics.fullWidth(context),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: Metrics.ph(context, !wrongId ? 60 : 65),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: space_conifer,
                        top: space_golden_dream,
                        right: space_conifer,
                      ),
                      child: H1(
                        text: "Invite people using these access codes:",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: space_golden_dream,
                      ),
                      child: RowInfo(
                        icon: Icons.star,
                        iconColor: mustard,
                        circleColor: lightMustard,
                        title: "Mentors:",
                        subTitle: _subTitle1,
                        buttonLabel: "Copy",
                        isSecondaryButton: true,
                        onPress: () {
                          Clipboard.setData(
                            ClipboardData(text: _subTitle1),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: space_fire_bush,
                      ),
                      child: RowInfo(
                        icon: Icons.person,
                        iconColor: purple,
                        circleColor: lightPurple,
                        title: "Participants:",
                        subTitle: _subTitle2,
                        buttonLabel: "Copy",
                        isSecondaryButton: true,
                        onPress: () {
                          Clipboard.setData(
                            ClipboardData(text: _subTitle2),
                          );
                        },
                      ),
                    ),
                    // PrimaryButton(
                    //   label: "Next",
                    //   onPress: () {},
                    // ),
                  ],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  left: leftOverFlow,
                  right: rightOverFlow,
                  bottom: bottomOverFlow,
                  child: PrimaryButton(
                    label: "Next",
                    onPress: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
