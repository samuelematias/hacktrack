import 'package:flutter/material.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/p/p2.dart';
import '../../themes/text/typography/p/p3.dart';
import '../../util/metrics.dart';
import '../../widget/input.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_button.dart';

class CreateRoomPage extends StatelessWidget {
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
    FocusNode _focusNode = FocusNode();
    final _inputController = TextEditingController();
    double leftOverFlow = -5.0;
    double rightOverFlow = -5.0;
    double bottomOverFlow = 0.0;
    bool wrongId = false;

    return SafeArea(
      child: Container(
        width: Metrics.fullWidth(context),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: Metrics.ph(context, 60),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: space_conifer,
                            top: space_golden_dream,
                            right: space_conifer,
                          ),
                          child: H1(
                            text: "Create your hackathon handle name:",
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
                            hint: "Handle name",
                            autofocus: true,
                            inputController: _inputController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                FocusScope.of(context).requestFocus(_focusNode),
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
                                  text: "Ex: hack-mit, hack-ny, etc.",
                                )
                              : P3(
                                  text:
                                      "Wrong access code, please check your code and try again.",
                                ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: space_dodger_blue,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: space_geraldine,
                              top: space_golden_dream,
                              right: space_geraldine,
                            ),
                            child: Input(
                              context: context,
                              hint: "Hackathon name",
                              focusNode: _focusNode,
                              inputController: _inputController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: space_heliotrope,
                              top: space_dodger_blue,
                              right: space_heliotrope,
                            ),
                            child: P2(
                              text: "Ex: HackMIT, Hack NY, etc.",
                            ),
                          ),
                        ],
                      ),
                    )
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
                    label: "Create",
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
