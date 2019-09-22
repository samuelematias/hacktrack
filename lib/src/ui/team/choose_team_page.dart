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
import '../../widget/custom_progress_indicator.dart';
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
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _init();

    super.initState();
  }

  void _init() {
    bloc.listTeams();
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
        child: StreamBuilder<List<TeamModel>>(
            stream: bloc.getTeams,
            builder: (context, snapshot) {
              bool empyList =
                  snapshot.hasError && snapshot.error.toString() == "204";
              bool handle404 =
                  snapshot.hasError && snapshot.error.toString() == "404";
              return handle404
                  ? Container(
                      child: Column(
                        children: <Widget>[
                          ErrorAlert(),
                          Padding(
                            padding: EdgeInsets.only(
                              top: space_geraldine,
                              // bottom: space_heliotrope,
                            ),
                            child: SecondaryButton(
                              label: "Try Again",
                              onPress: () => _init(),
                              width: Metrics.pw(context, 95),
                            ),
                          )
                        ],
                      ),
                    )
                  : !empyList
                      ? buildTeamsList(context, snapshot)
                      : Container(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  left: space_golden_dream,
                                  top: space_geraldine,
                                  right: space_golden_dream,
                                ),
                                child: SecondaryButton(
                                  label: "Create a Team",
                                  onPress: () =>
                                      Navigator.of(context).pushNamed(
                                    RoutesNames.createTeam,
                                  ),
                                  width: Metrics.pw(context, 95),
                                ),
                              ),
                            ],
                          ),
                        );
            }),
      ),
    );
  }

  Widget buildTeamsList(
      BuildContext context, AsyncSnapshot<List<TeamModel>> snapshot) {
    if (snapshot.hasData) {
      return Padding(
        padding: EdgeInsets.only(
          left: space_golden_dream,
          // top: space_golden_dream,
          right: space_golden_dream,
        ),
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshList,
          color: purple,
          backgroundColor: white,
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              TeamModel item = snapshot.data[index];
              // var key = teams.elementAt(index);
              return buildTeamsListItem(
                context,
                item,
                snapshot.data,
                index,
              );
            },
          ),
        ),
      );
    } else {
      return Center(child: CustomProgressIndicator());
    }
  }

  Widget buildTeamsListItem(
    BuildContext context,
    TeamModel item,
    List<TeamModel> teams,
    int index,
  ) {
    final bool isTheFirstPositionOfArray = index == 0;
    final bool isTheLastPositionOfArray = index + 1 == teams.length;
    return Container(
      padding: EdgeInsets.only(
        top: isTheFirstPositionOfArray ? 0.0 : space_golden_dream,
        bottom: isTheLastPositionOfArray ? space_heliotrope : 0.0,
      ),
      child: Column(
        children: <Widget>[
          isTheFirstPositionOfArray
              ? Padding(
                  padding: EdgeInsets.only(
                    left: space_conifer,
                    top: space_golden_dream,
                    right: space_conifer,
                    bottom: space_golden_dream,
                  ),
                  child: H4(
                    text: "Choose your team:",
                  ),
                )
              : Container(),
          RowInfo(
            icon: Icons.group,
            iconColor: darkGrey,
            circleColor: heavyGrey,
            title: item.name,
            subTitle: item.users.length == 1
                ? "${item.users.length} participant"
                : "${item.users.length} participants",
            buttonLabel: "Join",
            onPress: () =>
                CustomDialog.show(context, _buildDialogContent(context), 170),
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          isTheLastPositionOfArray
              ? Padding(
                  padding: EdgeInsets.only(
                    top: space_geraldine,
                    // bottom: space_heliotrope,
                  ),
                  child: SecondaryButton(
                    label: "Create team",
                    onPress: () => Navigator.of(context).pushNamed(
                      RoutesNames.createTeam,
                    ),
                    width: Metrics.pw(context, 95),
                  ),
                )
              : Container(),
        ],
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

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    _init();

    return null;
  }
}
