import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/team_model.dart';
import '../../shared/screen_arguments.dart';
import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/custom_image_picker.dart';
import '../../util/custom_modal.dart';
import '../../util/metrics.dart';
import '../../widget/auto_resize_text.dart';
import '../../widget/dashed_box.dart';
import '../../widget/error_alert.dart';
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
  FocusNode _focusNode = FocusNode();
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
  bool isFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);

    listenStatusUpdateResponse = bloc.createTrackPost.listen((data) {
      if (data.id != null) {
        storageService.setTeamStage(data.stage);
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.pop(context);
        widget.arguments.onSuccess();
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
    _focusNode.removeListener(_focusNodeListener);
    listenStatusUpdateResponse.cancel();
    listenStatusUpdateResponseLoading.cancel();
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    if (_focusNode.hasFocus) {
      leftOverFlow = -5.0;
      rightOverFlow = -5.0;
      bottomOverFlow = 0.0;
      isFocus = true;
    } else {
      leftOverFlow = 20.0;
      rightOverFlow = 20.0;
      bottomOverFlow = 25.0;
      isFocus = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: storageService.getTeamName(),
        context: context,
        onClickBackButton: !isLoading
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pop(context);
              }
            : () {},
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
                      StreamBuilder<TeamModel>(
                          stream: bloc.createTrackPost,
                          builder: (context, snapshot) {
                            bool handle404 = snapshot.hasError &&
                                snapshot.error.toString() == "404";
                            return Column(
                              children: <Widget>[
                                handle404 ? ErrorAlert() : Container(),
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
                              ],
                            );
                          }),
                      GestureDetector(
                        onTap: !isLoading && !isFocus
                            ? () => Navigator.of(context).push(
                                  CustomModal(
                                    context: context,
                                    modalContent: modalContent(),
                                    overlayHeight: 50.0,
                                  ),
                                )
                            : () {},
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
                              color: !isLoading ? grey : shadownGrey,
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
                                                  : "Choose your phase",
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
                              onTap: !isLoading
                                  ? () {
                                      bloc.trackStatus = "ok";
                                      bloc.handleStatus("ok", "");
                                      bloc.validateUpdateButton(
                                        bloc.trackStage,
                                        "ok",
                                        bloc.trackComment,
                                      );
                                    }
                                  : () {},
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
                              onTap: !isLoading
                                  ? () {
                                      bloc.trackStatus = "nok";
                                      bloc.handleStatus("", "nok");
                                      bloc.validateUpdateButton(
                                        bloc.trackStage,
                                        "nok",
                                        bloc.trackComment,
                                      );
                                    }
                                  : () {},
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
                          enabled: !isLoading,
                          controller: _inputController,
                          focusNode: _focusNode,
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
                          maxLength: 250,
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
                                    onTap: !isLoading
                                        ? () {
                                            return CustomImagePicker.show(
                                                context, (File imageCropped) {
                                              bloc.arrayPhotos
                                                  .add(imageCropped);
                                              setState(() {
                                                _firstImage = imageCropped;
                                              });
                                            }, false);
                                          }
                                        : () {},
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
                                    onTap: _firstImage != null && !isLoading
                                        ? () {
                                            return CustomImagePicker.show(
                                                context, (File imageCropped) {
                                              bloc.arrayPhotos
                                                  .add(imageCropped);
                                              setState(() {
                                                _secondImage = imageCropped;
                                              });
                                            }, false);
                                          }
                                        : () {},
                                    child: DashedBox(
                                      dasheColor: _firstImage != null
                                          ? grey
                                          : shadownGrey,
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
                                                color: _firstImage != null
                                                    ? grey
                                                    : shadownGrey,
                                              ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _firstImage != null &&
                                            _secondImage != null &&
                                            !isLoading
                                        ? () {
                                            return CustomImagePicker.show(
                                                context, (File imageCropped) {
                                              bloc.arrayPhotos
                                                  .add(imageCropped);
                                              setState(() {
                                                _thirdImage = imageCropped;
                                              });
                                            }, false);
                                          }
                                        : () {},
                                    child: DashedBox(
                                      dasheColor: _firstImage != null &&
                                              _secondImage != null
                                          ? grey
                                          : shadownGrey,
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
                                                color: _firstImage != null &&
                                                        _secondImage != null
                                                    ? grey
                                                    : shadownGrey,
                                              ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _firstImage != null &&
                                            _secondImage != null &&
                                            _thirdImage != null &&
                                            !isLoading
                                        ? () {
                                            return CustomImagePicker.show(
                                                context, (File imageCropped) {
                                              bloc.arrayPhotos
                                                  .add(imageCropped);
                                              setState(() {
                                                _fourthImage = imageCropped;
                                              });
                                            }, false);
                                          }
                                        : () {},
                                    child: DashedBox(
                                      dasheColor: _firstImage != null &&
                                              _secondImage != null &&
                                              _thirdImage != null
                                          ? grey
                                          : shadownGrey,
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
                                                color: _firstImage != null &&
                                                        _secondImage != null &&
                                                        _thirdImage != null
                                                    ? grey
                                                    : shadownGrey,
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
                            onPress: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_firstImage != null) {
                                bloc.uploadPhotoToS3();
                              } else {
                                bloc.createTrack();
                              }
                            },
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

  Widget modalContent() {
    List stages = [
      "Ideation",
      "Problem Definition",
      "Validation",
      "Solution",
      "Product",
      "Pitch",
    ];
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(space_fire_bush),
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 5.0,
          children: _buildContentList(stages, context),
        ),
      ),
    );
  }

  List<Widget> _buildContentList(List stages, BuildContext context) {
    return stages.map((data) => _buildContentListItem(data)).toList();
  }

  Widget _buildContentListItem(String stage) {
    return GestureDetector(
      onTap: () {
        bloc.trackStage = stage;
        bloc.addStage(stage);
        bloc.validateUpdateButton(
          stage,
          bloc.trackStatus,
          bloc.trackComment,
        );
        Navigator.pop(context);
      },
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: red,
          borderRadius: BorderRadius.all(Radius.circular(3)),
          border: Border.all(color: purple, width: 2),
        ),
        child: AutoResizeText(
          text: stage,
          containerTextWidth: 50,
          textAlign: TextAlign.center,
          textColor: bloc.trackStage == stage ? purple : black,
          maxLines: 2,
          fontSize: space_golden_dream,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
