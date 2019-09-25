import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/user_model.dart';
import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/metrics.dart';
import '../../widget/error_alert.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_appbar.dart';
import '../mentor/mentor_onboarding_page.dart';
import '../team/team_module.dart';
import 'profile_bloc.dart';
import 'profile_module.dart';

class CreateProfilePage extends StatefulWidget {
  // final CreateProfilePageArguments arguments;

  // CreateProfilePage({this.arguments});

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  static var storageService = locator<AppPreferencesService>();
  var bloc = ProfileModule.to.getBloc<ProfileBloc>();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  final _inputController1 = TextEditingController();
  final _inputController2 = TextEditingController();
  final _inputController3 = TextEditingController();
  final _inputController4 = TextEditingController();
  double leftOverFlow = -5.0;
  double rightOverFlow = -5.0;
  double bottomOverFlow = 0.0;
  StreamSubscription listenUserResponse;
  StreamSubscription listenUserResponseLoading;
  bool isLoading = false;
  bool isOwner = storageService.isCreateHackathonSuccess();

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
    listenUserResponse = bloc.userPost.listen((data) {
      if (data.id != null) {
        if (storageService.isMentor()) {
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
    listenUserResponseLoading = bloc.isShowLoading.listen((data) {
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
    listenUserResponse.cancel();
    listenUserResponseLoading.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: storageService.getHackathonName(),
        context: context,
        hideHeaderLeft: true,
        onClickBackButton: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
        },
      ),
      body: _bodyWidget(context, bloc),
    );
  }

  Widget _bodyWidget(BuildContext context, ProfileBloc bloc) {
    return SafeArea(
      child: Container(
        width: Metrics.fullWidth(context),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: !isOwner ? 525 : 425,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StreamBuilder<UserModel>(
                            stream: bloc.userPost,
                            builder: (context, snapshot) {
                              bool handle404 = snapshot.hasError &&
                                  snapshot.error.toString() == "404";
                              return Column(
                                children: <Widget>[
                                  handle404 ? ErrorAlert() : Container(),
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
                                ],
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.only(
                            left: space_geraldine,
                            top: space_golden_dream,
                            right: space_geraldine,
                          ),
                          child: TextField(
                            enabled: !isLoading,
                            controller: _inputController1,
                            onChanged: (String text) {
                              bloc.updateUserName(text);
                              bloc.userName = text;
                              bloc.validateCreateProfileButton(
                                text,
                                _inputController2.text,
                                isOwner ? 'Owner' : _inputController3.text,
                                _inputController4.text,
                              );
                            },
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_focusNode2),
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              color: black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle: TextStyle(color: black),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: purple, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: black, width: 1.0),
                              ),
                              fillColor: black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: space_geraldine,
                            top: space_golden_dream,
                            right: space_geraldine,
                          ),
                          child: StreamBuilder<String>(
                              initialData: '',
                              stream: bloc.getUserRole,
                              builder: (context, snapshot) {
                                return TextField(
                                  enabled: !isLoading,
                                  focusNode: _focusNode2,
                                  controller: _inputController2,
                                  onChanged: (String text) {
                                    bloc.updateUserEmail(text);
                                    bloc.userEmail = text;
                                    bloc.validateCreateProfileButton(
                                      _inputController1.text,
                                      text,
                                      isOwner
                                          ? 'Owner'
                                          : _inputController3.text,
                                      _inputController4.text,
                                    );
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context).requestFocus(
                                          !isOwner ? _focusNode3 : _focusNode4),
                                  // autofocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    color: black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(color: black),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: purple, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: black, width: 1.0),
                                    ),
                                    fillColor: black,
                                  ),
                                );
                              }),
                        ),
                        !isOwner
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left: space_geraldine,
                                  top: space_golden_dream,
                                  right: space_geraldine,
                                ),
                                child: StreamBuilder<String>(
                                    stream: bloc.getValidateCreateProfile,
                                    builder: (context, snapshot) {
                                      return TextField(
                                        enabled: !isLoading,
                                        focusNode: _focusNode3,
                                        controller: _inputController3,
                                        onChanged: (String text) {
                                          bloc.userRole = text;
                                          bloc.updateUserRole(text);
                                          bloc.validateCreateProfileButton(
                                            _inputController1.text,
                                            _inputController2.text,
                                            text,
                                            _inputController4.text,
                                          );
                                        },
                                        onEditingComplete: () =>
                                            FocusScope.of(context)
                                                .requestFocus(_focusNode4),
                                        maxLength: 20,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(
                                          color: black,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: "Your Role",
                                          labelStyle: TextStyle(color: black),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: purple, width: 2.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: black, width: 1.0),
                                          ),
                                          fillColor: black,
                                        ),
                                      );
                                    }),
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.only(
                            left: space_geraldine,
                            top: space_golden_dream,
                            right: space_geraldine,
                          ),
                          child: StreamBuilder<String>(
                              stream: bloc.getValidateCreateProfile,
                              builder: (context, snapshot) {
                                return TextField(
                                  enabled: !isLoading,
                                  focusNode: _focusNode4,
                                  controller: _inputController4,
                                  onChanged: (String text) {
                                    bloc.updateUserBio(text);
                                    bloc.userBio = text;
                                    bloc.validateCreateProfileButton(
                                      _inputController1.text,
                                      _inputController2.text,
                                      isOwner
                                          ? 'Owner'
                                          : _inputController3.text,
                                      text,
                                    );
                                  },
                                  onEditingComplete: () {
                                    if (snapshot.data == "ok") {
                                      bloc.createUser();
                                    }
                                  },
                                  maxLines: 2,
                                  maxLength: 100,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                    color: black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "Short bio",
                                    labelStyle: TextStyle(color: black),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: purple, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: black, width: 1.0),
                                    ),
                                    fillColor: black,
                                  ),
                                );
                              }),
                        )
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
                  child: StreamBuilder<String>(
                      stream: bloc.getValidateCreateProfile,
                      builder: (context, snapshot) {
                        return PrimaryButton(
                          label: "Create Profile",
                          onPress: () {
                            bloc.createUser();
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
    );
  }
}
