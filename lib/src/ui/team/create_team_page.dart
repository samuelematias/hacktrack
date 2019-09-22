import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/team_model.dart';
import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../themes/text/typography/p/p3.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_appbar.dart';
import 'team_bloc.dart';
import 'team_module.dart';

class CreateTeamPage extends StatefulWidget {
  @override
  _CreateTeamPageState createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  var bloc = TeamModule.to.getBloc<TeamBloc>();
  static var storageService = locator<AppPreferencesService>();
  final _inputController = TextEditingController();
  double leftOverFlow = -5.0;
  double rightOverFlow = -5.0;
  double bottomOverFlow = 0.0;
  bool wrongId = false;
  StreamSubscription listenCreateTeamResponse;
  StreamSubscription listenCreateTeamResponseLoading;
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
    listenCreateTeamResponse = bloc.createTeamPost.listen((data) {
      if (data.id != null) {
        Navigator.of(context).pushNamed(RoutesNames.team);
        // Navigator.of(
        //   context,
        // ).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (BuildContext context) => TeamPage(),
        //     ),
        //     (Route<dynamic> route) => false);
      }
    });
    listenCreateTeamResponseLoading = bloc.isShowLoading.listen((data) {
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
    listenCreateTeamResponse.cancel();
    listenCreateTeamResponseLoading.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: storageService.getHackathonName(),
        context: context,
        onClickBackButton: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
        },
      ),
      body: _bodyWidget(context, bloc),
    );
  }

  Widget _bodyWidget(BuildContext context, TeamBloc bloc) {
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
                    StreamBuilder<TeamModel>(
                        stream: bloc.createTeamPost,
                        builder: (context, snapshot) {
                          bool handle404 = snapshot.hasError &&
                              snapshot.error.toString() == "404";
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: Metrics.fullWidth(context),
                                    padding: EdgeInsets.only(
                                      left: space_conifer,
                                      top: space_golden_dream,
                                      right: space_conifer,
                                    ),
                                    child: H4(
                                      text: "Give a name to your team:",
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: space_geraldine,
                                  top: space_golden_dream,
                                  right: space_geraldine,
                                ),
                                child: TextField(
                                  controller: _inputController,
                                  onChanged: (String text) {
                                    bloc.updateTeamName(text);
                                    bloc.teamName = text;
                                    bloc.validateCreateTeamButton(text);
                                  },
                                  autofocus: true,
                                  keyboardType: TextInputType.text,
                                  // textInputAction: TextInputAction.done,
                                  style: TextStyle(
                                    color: black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "Team name",
                                    labelStyle: TextStyle(color: black),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: !handle404 ? purple : red,
                                          width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: !handle404 ? black : red,
                                          width: 1.0),
                                    ),
                                    fillColor: black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: space_heliotrope,
                                  top: space_dodger_blue,
                                  right: space_heliotrope,
                                ),
                                child: handle404
                                    ? P3(
                                        text: "Team Name already exists!",
                                      )
                                    : Container(),
                              ),
                            ],
                          );
                        }),
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
                      stream: bloc.getValidateCreateTeam,
                      builder: (context, snapshot) {
                        return PrimaryButton(
                          label: "Create Team",
                          onPress: () => bloc.createTeam(),
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
