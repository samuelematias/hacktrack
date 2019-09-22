import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/team_model.dart';
import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h2.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../themes/text/typography/p/p1.dart';
import '../../util/custom_dialog.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../widget/circle_icon.dart';
import '../../widget/error_alert.dart';
import '../../widget/primary_button.dart';
import '../../widget/row_info.dart';
import '../../widget/secondary_appbar.dart';
import '../../widget/secondary_button.dart';
import 'team_bloc.dart';
import 'team_module.dart';

class ChooseTeamPage extends StatefulWidget {
  @override
  _ChooseTeamPageState createState() => _ChooseTeamPageState();
}

class _ChooseTeamPageState extends State<ChooseTeamPage> {
  var bloc = TeamModule.to.getBloc<TeamBloc>();
  static var storageService = locator<AppPreferencesService>();

  @override
  void initState() {
    bloc.listTeams();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: storageService.getHackathonName(),
        hideHeaderLeft: true,
        context: context,
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
              child: StreamBuilder<List<TeamModel>>(
                  stream: bloc.getTeams,
                  builder: (context, snapshot) {
                    bool empyList =
                        snapshot.hasError && snapshot.error.toString() == "204";
                    bool handle404 =
                        snapshot.hasError && snapshot.error.toString() == "404";
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        handle404 ? ErrorAlert() : Container(),
                        Padding(
                          padding: EdgeInsets.only(
                            left: space_conifer,
                            top: space_golden_dream,
                            right: space_conifer,
                          ),
                          child: H4(
                            text: "Choose your team:",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: space_golden_dream,
                            top: space_geraldine,
                            right: space_golden_dream,
                            // bottom: space_scooter,
                          ),
                          child:
                              !empyList ? buildTeamsList(context) : Container(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: space_geraldine,
                            bottom: space_heliotrope,
                          ),
                          child: SecondaryButton(
                            label: "Create team",
                            onPress: () => Navigator.of(context).pushNamed(
                              RoutesNames.createTeam,
                            ),
                            width: Metrics.pw(context, 95),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamsList(BuildContext context) {
    List<Map<String, dynamic>> teams = [
      {
        'photo': '',
        'onPress': () {},
        'title': 'Team Fire',
        'subTitle': '5 participants',
      },
      {
        'photo': '',
        'onPress': () {},
        'title': 'Team 999',
        'subTitle': '3 participants',
      },
      {
        'photo': '',
        'onPress': () {},
        'title': 'Team Inovative',
        'subTitle': '1 participants',
      },
      {
        'photo': '',
        'onPress': () {},
        'title': 'Team Garage',
        'subTitle': '0 participants',
      },
      {
        'photo': '',
        'onPress': () {},
        'title': 'Team Fire',
        'subTitle': '5 participants',
      },
      {
        'photo': '',
        'onPress': () {},
        'title': 'Team 999',
        'subTitle': '3 participants',
      },
      {
        'photo': '',
        'onPress': () {},
        'title': 'Team Inovative',
        'subTitle': '1 participants',
      },
      {
        'photo': '',
        'onPress': () {},
        'title': 'Team Garage',
        'subTitle': '0 participants',
      },
      {
        'photo': '',
        'onPress': () {},
        'title': 'Team Inovative',
        'subTitle': '1 participants',
      },
      {
        'photo': '',
        'onPress': () {},
        'title': 'Team Garage',
        'subTitle': '0 participants',
      },
    ];

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: teams.length,
        itemBuilder: (context, index) {
          var key = teams.elementAt(index);
          return buildTeamsListItem(
            context,
            key,
            teams,
            index,
          );
        },
      ),
    );
  }

  Widget buildTeamsListItem(
    BuildContext context,
    Map<String, dynamic> key,
    List<Map<String, dynamic>> teams,
    int index,
  ) {
    final bool isTheFirstPositionOfArray = index == 0;
    return Padding(
      padding: EdgeInsets.only(
        top: isTheFirstPositionOfArray ? 0.0 : space_golden_dream,
      ),
      child: RowInfo(
        icon: Icons.group,
        iconColor: darkGrey,
        circleColor: heavyGrey,
        title: key['title'],
        subTitle: key['subTitle'],
        buttonLabel: "Join",
        onPress: () =>
            CustomDialog.show(context, _buildDialogContent(context), 170),
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        H4(
          text: "Are your sure you want to join this team?",
        ),
        Padding(
          padding: EdgeInsets.only(
            top: space_dodger_blue,
            bottom: space_fire_bush,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: Main,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleIcon(
                          icon: Icons.group,
                          iconColor: lightGrey,
                          circleColor: grey,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: space_dodger_blue,
                              ),
                              child: H2(
                                text: "Team Fire",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: space_dodger_blue,
                                top: space_carmine,
                              ),
                              child: P1(
                                text: "5 participants",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SecondaryButton(
                    label: "Cancel",
                    onPress: () => Navigator.pop(context),
                    width: 100,
                    borderColor: lightRed,
                    labelColor: red,
                  ),
                  PrimaryButton(
                    label: "Join",
                    onPress: () {
                      Navigator.pop(context);
                      return Navigator.of(context).pushNamed(RoutesNames.team);
                    },
                    width: 100,
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
