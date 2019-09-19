import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/p/p2.dart';
import '../../themes/text/typography/p/p3.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../widget/input.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_button.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _inputController = TextEditingController();
  double leftOverFlow = -5.0;
  double rightOverFlow = -5.0;
  double bottomOverFlow = 0.0;
  bool wrongId = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible) {
          leftOverFlow = -5.0;
          rightOverFlow = -5.0;
          bottomOverFlow = 0.0;
        } else {
          leftOverFlow = 20.0;
          rightOverFlow = 20.0;
          bottomOverFlow = 25.0;
        }
      },
    );
  }

  @override
  void dispose() {
    KeyboardVisibilityNotification().dispose();
    super.dispose();
  }

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
    return SafeArea(
      child: Container(
        width: Metrics.fullWidth(context),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: space_conifer,
                    top: space_golden_dream,
                    right: space_conifer,
                  ),
                  child: H1(
                    text: "Enter your hackathon access code:",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: space_geraldine,
                    top: space_golden_dream,
                    right: space_geraldine,
                  ),
                  child: Input(
                    context: context,
                    hint: "Access code",
                    autofocus: true,
                    // focusNode: _focusNode,
                    inputController: _inputController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: space_heliotrope,
                    top: space_dodger_blue,
                    right: space_heliotrope,
                  ),
                  child: !wrongId
                      ? P2(
                          text:
                              "This is the code your organizer has sent you. Please contact them if you do not have this code.",
                        )
                      : P3(
                          text:
                              "Wrong access code, please check your code and try again.",
                        ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  left: leftOverFlow,
                  right: rightOverFlow,
                  bottom: bottomOverFlow,
                  child: PrimaryButton(
                    label: "Join",
                    onPress: () => Navigator.of(context).pushNamed(
                      RoutesNames.chooseTeam,
                    ),
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
