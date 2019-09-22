import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/p/p2.dart';
import '../../themes/text/typography/p/p3.dart';
import '../../util/metrics.dart';
import '../../widget/error_alert.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_button.dart';
import '../mentor/mentor_onboarding_page.dart';
import '../team/team_module.dart';
import 'join_bloc.dart';
import 'join_module.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  var bloc = JoinModule.to.getBloc<JoinBloc>();
  final _inputController = TextEditingController();
  double leftOverFlow = -5.0;
  double rightOverFlow = -5.0;
  double bottomOverFlow = 0.0;
  StreamSubscription listenValidateCodeResponse;
  StreamSubscription listenValidateCodeResponseLoading;
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
    listenValidateCodeResponse = bloc.getValidateCode.listen((data) {
      if (data.status == "ok") {
        if (data.isMentor) {
          Navigator.of(
            context,
          ).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => MentorOnboardingPage(),
              ),
              (Route<dynamic> route) => false);
        } else {
          Navigator.of(
            context,
          ).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => TeamModule(),
              ),
              (Route<dynamic> route) => false);
        }
      }
    });
    listenValidateCodeResponseLoading = bloc.isShowLoading.listen((data) {
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
    listenValidateCodeResponse.cancel();
    listenValidateCodeResponseLoading.cancel();
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
      body: _bodyWidget(context, bloc),
    );
  }

  Widget _bodyWidget(BuildContext context, JoinBloc bloc) {
    return SafeArea(
      child: Container(
        width: Metrics.fullWidth(context),
        child: Stack(
          children: <Widget>[
            StreamBuilder<Object>(
                stream: bloc.getValidateCode,
                builder: (context, snapshot) {
                  bool joinCodeInvalid =
                      snapshot.hasError && snapshot.error.toString() == "226";
                  bool handle404 =
                      snapshot.hasError && snapshot.error.toString() == "404";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      handle404 ? ErrorAlert() : Container(),
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
                        child: StreamBuilder<String>(
                            stream: bloc.getValidateJoin,
                            builder: (context, snapshot) {
                              return TextField(
                                enabled: !isLoading,
                                controller: _inputController,
                                onChanged: (String text) {
                                  bloc.updateJoinCode(text);
                                  bloc.joinCode = text;
                                  bloc.validateJoinButton(text);
                                },
                                onEditingComplete: () {
                                  if (snapshot.data == "ok") {
                                    bloc.validateCode();
                                  }
                                },
                                autofocus: true,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(
                                  color: black,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Access code",
                                  labelStyle: TextStyle(color: black),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: !joinCodeInvalid ? purple : red,
                                        width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: !joinCodeInvalid ? black : red,
                                        width: 1.0),
                                  ),
                                  fillColor: black,
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: space_heliotrope,
                          top: space_dodger_blue,
                          right: space_heliotrope,
                        ),
                        child: !joinCodeInvalid
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
                  );
                }),
            Stack(
              children: <Widget>[
                Positioned(
                  left: leftOverFlow,
                  right: rightOverFlow,
                  bottom: bottomOverFlow,
                  child: StreamBuilder<String>(
                      stream: bloc.getValidateJoin,
                      builder: (context, snapshot) {
                        return PrimaryButton(
                          label: "Join",
                          onPress: () => bloc.validateCode(),
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
    );
  }
}
