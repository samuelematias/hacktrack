import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_appbar.dart';
import 'create_bloc.dart';
import 'create_module.dart';

class CreateProfilePage extends StatefulWidget {
  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  var bloc = CreateModule.to.getBloc<CreateBloc>();
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
      appBar: SecondaryAppBar(
        pageTitle: "Shawee",
        context: context,
        onClickBackButton: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
        },
      ),
      body: _bodyWidget(context, bloc),
    );
  }

  Widget _bodyWidget(BuildContext context, CreateBloc bloc) {
    return SafeArea(
      child: Container(
        width: Metrics.fullWidth(context),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: 450,
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
                            left: space_geraldine,
                            top: space_golden_dream,
                            right: space_geraldine,
                          ),
                          child: TextField(
                            controller: _inputController1,
                            onChanged: (String text) {
                              bloc.updateUserName(text);
                              bloc.validateCreateProfileButton(
                                text,
                                _inputController2.text,
                                _inputController3.text,
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
                          child: TextField(
                            focusNode: _focusNode2,
                            controller: _inputController2,
                            onChanged: (String text) {
                              bloc.updateUserEmail(text);
                              bloc.validateCreateProfileButton(
                                _inputController1.text,
                                text,
                                _inputController3.text,
                                _inputController4.text,
                              );
                            },
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_focusNode3),
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
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: space_geraldine,
                            top: space_golden_dream,
                            right: space_geraldine,
                          ),
                          child: TextField(
                            focusNode: _focusNode3,
                            controller: _inputController3,
                            onChanged: (String text) {
                              bloc.updateUserRole(text);
                              bloc.validateCreateProfileButton(
                                _inputController1.text,
                                _inputController2.text,
                                text,
                                _inputController4.text,
                              );
                            },
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_focusNode4),
                            // autofocus: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              color: black,
                            ),
                            decoration: InputDecoration(
                              labelText: "Role (Designer, Front End, etc.)",
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
                              stream: bloc.getValidateCreateProfile,
                              builder: (context, snapshot) {
                                return TextField(
                                  focusNode: _focusNode4,
                                  controller: _inputController4,
                                  onChanged: (String text) {
                                    bloc.updateUserRole(text);
                                    bloc.validateCreateProfileButton(
                                      _inputController1.text,
                                      _inputController2.text,
                                      _inputController3.text,
                                      text,
                                    );
                                  },
                                  onEditingComplete: () {
                                    if (snapshot.data == "ok") {
                                      Navigator.of(context).pushNamed(
                                        RoutesNames.mentorOnboarding,
                                      );
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
                            Navigator.of(context).pushNamed(
                              RoutesNames.mentorOnboarding,
                            );
                            // Future.delayed(
                            //     const Duration(seconds: 2),
                            //     () => Navigator.of(context).pushNamed(
                            //           RoutesNames.mentorOnboarding,
                            //         ));
                          },
                          isDisable: snapshot.data,
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
