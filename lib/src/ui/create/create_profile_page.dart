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

class CreateProfilePage extends StatelessWidget {
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
    FocusNode _focusNode2 = FocusNode();
    final _inputController1 = TextEditingController();
    final _inputController2 = TextEditingController();
    final _inputController3 = TextEditingController();
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
                height: 400,
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
                          child: H4(
                            text:
                                "Tell your mentors and colleagues more about you:",
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
                            hint: "Name",
                            autofocus: true,
                            inputController: _inputController1,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_focusNode1),
                            borderSideColorOnFocus: !wrongId ? purple : red,
                            borderSideUnFocus: !wrongId ? black : red,
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
                            hint: "Role (Designer, Front End, etc.)",
                            focusNode: _focusNode1,
                            inputController: _inputController2,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_focusNode2),
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
                            hint: "Short bio",
                            focusNode: _focusNode2,
                            inputController: _inputController3,
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
                    label: "Create",
                    onPress: () => Navigator.of(context).pushNamed(
                      RoutesNames.createCodes,
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
