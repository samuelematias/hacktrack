import 'dart:io';

import 'package:flutter/material.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/custom_image_picker.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../widget/input.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_appbar.dart';

class CreateTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: "Shawee",
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
    FocusNode _focusNode1 = FocusNode();
    final _inputController1 = TextEditingController();
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
                width: Metrics.fullWidth(context),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: Metrics.fullWidth(context),
                          padding: EdgeInsets.only(
                            left: space_conifer,
                            top: space_golden_dream,
                            right: space_conifer,
                          ),
                          child: H4(
                            text: "Give a name and face to your team:",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: space_golden_dream,
                          ),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    // Positioned(
                                    //   left: 12.0,
                                    //   top: 12.0,
                                    //   child: Center(
                                    //     child: Container(
                                    //       // color: red,
                                    //       child: Container(),
                                    //     ),
                                    //   ),
                                    // ),
                                    Center(
                                      child: Container(
                                        width: space_conifer,
                                        height: space_conifer,
                                        decoration: BoxDecoration(
                                          color: overlay,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                          width: space_conifer,
                                          height: space_conifer,
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: grey,
                                          )),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          return CustomImagePicker.show(context,
                                              (File imageCropped) {
                                            // setState(() {
                                            //   _image = imageCropped;
                                            // });
                                          }, true);
                                        },
                                        child: Container(
                                          width: space_conifer,
                                          height: space_conifer,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                            hint: "Team Name",
                            autofocus: true,
                            inputController: _inputController1,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_focusNode1),
                            borderSideColorOnFocus: !wrongId ? purple : red,
                            borderSideUnFocus: !wrongId ? black : red,
                          ),
                        ),
                      ],
                    ),
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
                    label: "Create Team",
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
