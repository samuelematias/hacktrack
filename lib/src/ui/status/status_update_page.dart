import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/screen_arguments.dart';
import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/custom_image_picker.dart';
import '../../util/metrics.dart';
import '../../widget/dashed_box.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_appbar.dart';
import 'status_bloc.dart';
import 'status_module.dart';

class StatusUpdatePage extends StatefulWidget {
  final StatusUpdateArguments arguments;

  StatusUpdatePage({this.arguments});

  @override
  _StatusUpdatePageState createState() => _StatusUpdatePageState();
}

class _StatusUpdatePageState extends State<StatusUpdatePage> {
  var bloc = StatusModule.to.getBloc<StatusBloc>();
  static var storageService = locator<AppPreferencesService>();
  final _inputController = TextEditingController();
  double leftOverFlow = 20.0;
  double rightOverFlow = 20.0;
  double bottomOverFlow = 25.0;
  File _firstImage;
  File _secondImage;
  File _thirdImage;
  File _fourthImage;
  StreamSubscription listenStatusUpdateResponse;
  StreamSubscription listenStatusUpdateResponseLoading;
  bool isLoading = false;

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

    listenStatusUpdateResponse = bloc.createTrackPost.listen((data) {
      if (data.id != null) {
        // if (storageService.isMentor()) {
        //   bloc.getTeamTrack();
        // }
        storageService.setTeamStage(data.stage);
        Navigator.pop(context);
        widget.arguments.onSuccess();

        // if (_firstImage != null) {
        //   bloc.uploadFoto(_firstImage);
        // }
      }
    });
    listenStatusUpdateResponseLoading = bloc.isShowLoading.listen((data) {
      if (data) {
        setState(() {
          isLoading = data;
        });
      } else {
        setState(() {
          isLoading = data;
        });
      }
    });
  }

  @override
  void dispose() {
    KeyboardVisibilityNotification().dispose();
    listenStatusUpdateResponse.cancel();
    listenStatusUpdateResponseLoading.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: "Team Fire",
        context: context,
      ),
      body: _bodyWidget(context, bloc),
    );
  }

  Widget _bodyWidget(BuildContext context, StatusBloc bloc) {
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
                        onTap: () => _showPicker(context, bloc),
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
                                      child: StreamBuilder<String>(
                                          stream: bloc.getStage,
                                          builder: (context, snapshot) {
                                            return H4(
                                              text: snapshot.hasData
                                                  ? snapshot.data
                                                  : "Ideation",
                                            );
                                          }),
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
                              onTap: () {
                                bloc.trackStatus = "ok";
                                bloc.handleStatus("ok", "");
                                bloc.validateUpdateButton(
                                  bloc.trackStage,
                                  "ok",
                                  bloc.trackComment,
                                );
                              },
                              child: StreamBuilder<String>(
                                  stream: bloc.getStatusOk,
                                  builder: (context, snapshot) {
                                    bool doubleCheckOk = snapshot.hasData &&
                                        snapshot.data == "ok";
                                    return Container(
                                      padding: EdgeInsets.only(
                                        left: space_dodger_blue,
                                        top: space_carmine,
                                        right: space_dodger_blue,
                                        bottom: space_carmine,
                                      ),
                                      decoration: BoxDecoration(
                                        color: doubleCheckOk
                                            ? green
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: doubleCheckOk
                                              ? green
                                              : lightGreen,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Killin' it! 🍾",
                                            style: TextStyle(
                                              fontSize: space_golden_dream,
                                              color:
                                                  doubleCheckOk ? white : green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
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
                              onTap: () {
                                bloc.trackStatus = "nok";
                                bloc.handleStatus("", "nok");
                                bloc.validateUpdateButton(
                                  bloc.trackStage,
                                  "nok",
                                  bloc.trackComment,
                                );
                              },
                              child: StreamBuilder<String>(
                                  stream: bloc.getStatusNok,
                                  builder: (context, snapshot) {
                                    bool doubleCheckNok = snapshot.hasData &&
                                        snapshot.data == "nok";
                                    return Container(
                                      padding: EdgeInsets.only(
                                        left: space_dodger_blue,
                                        top: space_carmine,
                                        right: space_dodger_blue,
                                        bottom: space_carmine,
                                      ),
                                      decoration: BoxDecoration(
                                        color: doubleCheckNok
                                            ? red
                                            : Colors.transparent,
                                        border: Border.all(
                                          color:
                                              doubleCheckNok ? red : lightRed,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Need help 🚨",
                                            style: TextStyle(
                                              fontSize: space_golden_dream,
                                              color:
                                                  doubleCheckNok ? white : red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
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
                          controller: _inputController,
                          onChanged: (String text) {
                            bloc.updateComment(text);
                            bloc.trackComment = text;
                            bloc.validateUpdateButton(
                              bloc.trackStage,
                              bloc.trackStatus,
                              text == null ? "" : text,
                            );
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          maxLines: 3,
                          maxLength: 100,
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
                                        setState(() {
                                          _firstImage = imageCropped;
                                        });
                                      }, false);
                                    },
                                    child: DashedBox(
                                      child: Center(
                                        child: _firstImage != null
                                            ? Container(
                                                width: 60.0,
                                                height: 60.0,
                                                child: Image.file(
                                                  _firstImage,
                                                  fit: BoxFit.fitHeight,
                                                  width: 60.0,
                                                  height: 60.0,
                                                ),
                                              )
                                            : Icon(
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
                                        setState(() {
                                          _secondImage = imageCropped;
                                        });
                                      }, false);
                                    },
                                    child: DashedBox(
                                      child: Center(
                                        child: _secondImage != null
                                            ? Container(
                                                width: 60.0,
                                                height: 60.0,
                                                child: Image.file(
                                                  _secondImage,
                                                  fit: BoxFit.fitHeight,
                                                  width: 60.0,
                                                  height: 60.0,
                                                ),
                                              )
                                            : Icon(
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
                                        setState(() {
                                          _thirdImage = imageCropped;
                                        });
                                      }, false);
                                    },
                                    child: DashedBox(
                                      child: Center(
                                        child: _thirdImage != null
                                            ? Container(
                                                width: 60.0,
                                                height: 60.0,
                                                child: Image.file(
                                                  _thirdImage,
                                                  fit: BoxFit.fitHeight,
                                                  width: 60.0,
                                                  height: 60.0,
                                                ),
                                              )
                                            : Icon(
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
                                        setState(() {
                                          _fourthImage = imageCropped;
                                        });
                                      }, false);
                                    },
                                    child: DashedBox(
                                      child: Center(
                                        child: _fourthImage != null
                                            ? Container(
                                                width: 60.0,
                                                height: 60.0,
                                                child: Image.file(
                                                  _fourthImage,
                                                  fit: BoxFit.fitHeight,
                                                  width: 60.0,
                                                  height: 60.0,
                                                ),
                                              )
                                            : Icon(
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
                    child: StreamBuilder<String>(
                        stream: bloc.getValidateUpdate,
                        builder: (context, snapshot) {
                          return PrimaryButton(
                            label: "Update",
                            onPress: () => bloc.createTrack(),
                            isDisable: snapshot.data,
                            isLoading: isLoading,
                          );
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _showPicker(BuildContext context, StatusBloc bloc) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.transparent,
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              children: <Widget>[
                Container(
                  child: H4(
                    text: "Ideation",
                  ),
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
                bloc.trackStage = _chooseSTage(index);
                bloc.addStage(_chooseSTage(index));
                bloc.validateUpdateButton(
                  _chooseSTage(index),
                  bloc.trackStatus,
                  bloc.trackComment,
                );
              },
            ),
          ),
        );
      },
    );
  }

  String _chooseSTage(int index) {
    if (index == 0) {
      return "Ideation";
    } else if (index == 1) {
      return "Problem Definition";
    } else if (index == 2) {
      return "Validation";
    } else if (index == 3) {
      return "Solution";
    } else if (index == 4) {
      return "Product";
    } else if (index == 5) {
      return "Pitch";
    } else {
      return "Ideation";
    }
  }
}
