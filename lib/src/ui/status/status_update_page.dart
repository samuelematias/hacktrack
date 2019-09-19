import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/custom_image_picker.dart';
import '../../util/metrics.dart';
import '../../widget/dashed_box.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_appbar.dart';

class StatusUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: "Team Fire",
        context: context,
      ),
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    // final _inputController1 = TextEditingController();
    double leftOverFlow = -5.0;
    double rightOverFlow = -5.0;
    double bottomOverFlow = 0.0;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  color: Colors.transparent,
                  height: 420,
                  width: Metrics.fullWidth(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: space_conifer,
                          top: space_golden_dream,
                          right: space_conifer,
                        ),
                        child: H4(
                          text: "Update your status",
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showPicker(context),
                        child: Container(
                          margin: EdgeInsets.only(
                            left: space_golden_dream,
                            top: space_golden_dream,
                            right: space_golden_dream,
                          ),
                          height: space_portage,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: space_dodger_blue,
                                      ),
                                      child: H4(
                                        text: "Problem",
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: space_dodger_blue,
                                      ),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    )
                                  ],
                                ),
                              ),
                            ],
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
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: space_dodger_blue,
                                  top: space_carmine,
                                  right: space_dodger_blue,
                                  bottom: space_carmine,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: lightGreen,
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Killin' it! 🍾",
                                      style: TextStyle(
                                        fontSize: space_golden_dream,
                                        color: green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              "or",
                              style: TextStyle(
                                fontSize: space_dodger_blue,
                                color: lightGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: space_dodger_blue,
                                  top: space_carmine,
                                  right: space_dodger_blue,
                                  bottom: space_carmine,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: lightRed,
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Need help 🚨",
                                      style: TextStyle(
                                        fontSize: space_golden_dream,
                                        color: red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: space_golden_dream,
                          top: space_dodger_blue,
                          right: space_golden_dream,
                        ),
                        child: TextField(
                          // controller: _inputController1,
                          onChanged: (text) {},
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          maxLines: 3,
                          maxLength: 200,
                          style: TextStyle(
                            color: black,
                          ),
                          decoration: InputDecoration(
                            labelText: "Status comments",
                            labelStyle: TextStyle(color: lightGrey),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: purple, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: grey, width: 1.0),
                            ),
                            fillColor: black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: space_fire_bush,
                          top: space_spring_green,
                          right: space_golden_dream,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      return CustomImagePicker.show(context,
                                          (File imageCropped) {
                                        // setState(() {
                                        //   _image = imageCropped;
                                        // });
                                      }, true);
                                    },
                                    child: DashedBox(
                                      child: Center(
                                        child: Icon(
                                          Icons.image,
                                          color: grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      return CustomImagePicker.show(context,
                                          (File imageCropped) {
                                        // setState(() {
                                        //   _image = imageCropped;
                                        // });
                                      }, true);
                                    },
                                    child: DashedBox(
                                      child: Center(
                                        child: Icon(
                                          Icons.image,
                                          color: grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      return CustomImagePicker.show(context,
                                          (File imageCropped) {
                                        // setState(() {
                                        //   _image = imageCropped;
                                        // });
                                      }, true);
                                    },
                                    child: DashedBox(
                                      child: Center(
                                        child: Icon(
                                          Icons.image,
                                          color: grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      return CustomImagePicker.show(context,
                                          (File imageCropped) {
                                        // setState(() {
                                        //   _image = imageCropped;
                                        // });
                                      }, true);
                                    },
                                    child: DashedBox(
                                      child: Center(
                                        child: Icon(
                                          Icons.image,
                                          color: grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                      label: "Update",
                      onPress: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _showPicker(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            children: <Widget>[
              H4(
                text: "Ideation",
              ),
              H4(
                text: "Problem Definition",
              ),
              H4(
                text: "Validation",
              ),
              H4(
                text: "Solution",
              ),
              H4(
                text: "Product",
              ),
              H4(
                text: "Pitch",
              ),
            ],
            itemExtent: 30, //height of each item
            looping: false,
            onSelectedItemChanged: (int index) {
              // selectitem = index;
            },
          ),
        );
      },
    );
  }
}
