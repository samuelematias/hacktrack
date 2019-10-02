import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/team_model.dart';
import '../../themes/color_palette.dart';
import '../../themes/images_gallery.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/h/h3.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/custom_dialog.dart';
import '../../util/custom_modal.dart';
import '../../util/metrics.dart';
import '../../widget/card_track_team.dart';
import '../../widget/custom_progress_indicator.dart';
import '../../widget/error_alert.dart';
import '../../widget/flash_message.dart';
import '../../widget/primary_button.dart';
import '../../widget/row_info.dart';
import '../../widget/secondary_appbar.dart';
import '../../widget/secondary_button.dart';
import '../start/start_page.dart';
import '../status/status_module.dart';
import 'mentor_bloc.dart';
import 'mentor_module.dart';

class MentorDashboardPage extends StatefulWidget {
  @override
  _MentorDashboardPageState createState() => _MentorDashboardPageState();
}

class _MentorDashboardPageState extends State<MentorDashboardPage> {
  var bloc = MentorModule.to.getBloc<MentorBloc>();
  static var storageService = locator<AppPreferencesService>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  StreamSubscription listenListTeamResponseLoading;
  bool isLoading = false;
  String _mentorsCode = storageService.getMentorCode();
  String _participantsCode = storageService.getParticipantCode();

  @override
  void initState() {
    _init();
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    listenListTeamResponseLoading = bloc.isShowLoading.listen((data) {
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

  void _init() {
    bloc.listTeams();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    listenListTeamResponseLoading.cancel();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    return true; // Disable Android Backbutton.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: storageService.getHackathonName(),
        context: context,
        showHeaderRight: true,
        customHeaderLeft: true,
        onClickCustomHeaderLeft: () =>
            CustomDialog.show(context, _buildDialogContent(context), 110),
        onClickHeaderRight: () => _init(),
      ),
      body: _bodyWidget(context, bloc),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          CustomModal(
            context: context,
            modalContent: modalContent(),
            overlayHeight: 50.0,
          ),
        ),
        child: Icon(
          Icons.content_paste,
          color: white,
        ),
        backgroundColor: purple,
      ),
    );
  }

  Widget _bodyWidget(BuildContext context, MentorBloc bloc) {
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
                  : empyList
                      ? Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                isLoading
                                    ? Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 10, top: 10),
                                          child: CustomProgressIndicator(
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: <Widget>[
                                          Image(
                                            image: AssetImage(imgblank),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: H3(
                                              text: "No Teams created yet!",
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: space_golden_dream,
                                              top: space_geraldine,
                                              right: space_golden_dream,
                                            ),
                                            child: SecondaryButton(
                                              label: "Refresh",
                                              onPress: () => _init(),
                                              width: Metrics.pw(context, 95),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        )
                      : isLoading
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: CustomProgressIndicator(
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            )
                          : buildTeamsList(context, snapshot);
            }),
      ),
    );
  }

  Widget buildTeamsList(
      BuildContext context, AsyncSnapshot<List<TeamModel>> snapshot) {
    if (snapshot.hasData) {
      return Container(
        padding: EdgeInsets.only(
          left: space_spring_green,
          // top: space_golden_dream,
          right: space_spring_green,
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
    final String totalParticipants = item.users.length == 1
        ? "${item.users.length} participant"
        : "${item.users.length} participants";
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
                    top: space_geraldine,
                  ),
                )
              : Container(),
          GestureDetector(
            onTap: () {
              storageService.setTeamId(item.id);
              storageService.setTeamStage(item.stage);
              storageService.setTeamName(item.name);
              Navigator.of(
                context,
              ).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => StatusModule(),
                  ),
                  (Route<dynamic> route) => false);
            },
            child: Container(
              width: Metrics.fullWidth(context),
              color: Colors.green,
              child: CardTrackTeam(
                isDashed: true,
                teamName: item.name,
                teamCount: totalParticipants,
                stage: item.stage,
                updatedAt: item.status == 'ok'
                    ? "Everything is ok with this team :)"
                    : item.status == 'nok'
                        ? "This team is in trouble!"
                        : "No team updates yet!",
                updatedAtColor: item.status == 'ok'
                    ? green
                    : item.status == 'nok' ? red : mustard,
                about: '',
                aboutColor: item.status == 'ok'
                    ? green
                    : item.status == 'nok' ? red : mustard,
                iconColor: item.status == 'ok'
                    ? green
                    : item.status == 'nok' ? red : mustard,
                circleColor: item.status == 'ok'
                    ? lightGreen
                    : item.status == 'nok' ? lightRed : lightMustard,
                onPress: () {
                  storageService.setTeamId(item.id);
                  storageService.setTeamStage(item.stage);
                  storageService.setTeamName(item.name);
                  Navigator.of(
                    context,
                  ).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => StatusModule(),
                      ),
                      (Route<dynamic> route) => false);
                  // Navigator.of(context).pushNamed(RoutesNames.team);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: space_golden_dream,
          ),
          child: H4(
            text: "Are your sure you want to exit the hackathon?",
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
                  ),
                  PrimaryButton(
                    label: "Exit",
                    onPress: () {
                      storageService.clear();
                      Navigator.pop(context);
                      return Navigator.of(
                        context,
                      ).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) => StartPage(),
                          ),
                          (Route<dynamic> route) => false);
                    },
                    width: 100,
                    borderColor: red,
                    buttonColor: red,
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

  Widget modalContent() {
    return Center(
      child: GestureDetector(
        onHorizontalDragDown: (e) => Navigator.pop(context),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: space_conifer,
                  top: space_golden_dream,
                  right: space_conifer,
                ),
                child: H1(
                  text: "Invite people using these access codes:",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: space_dodger_blue,
                  top: space_golden_dream,
                  right: space_dodger_blue,
                ),
                child: RowInfo(
                  icon: Icons.star,
                  iconColor: mustard,
                  circleColor: lightMustard,
                  title: "Mentors:",
                  subTitle: _mentorsCode,
                  buttonLabel: "Copy",
                  isSecondaryButton: true,
                  rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                  onPress: () {
                    Clipboard.setData(
                      ClipboardData(text: _mentorsCode),
                    );
                    // Navigator.pop(context);
                    _showCenterFlash(
                      'Mentor',
                      position: FlashPosition.top,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: space_dodger_blue,
                  top: space_fire_bush,
                  right: space_dodger_blue,
                ),
                child: RowInfo(
                  icon: Icons.person,
                  iconColor: purple,
                  circleColor: lightPurple,
                  title: "Participants:",
                  subTitle: _participantsCode,
                  buttonLabel: "Copy",
                  isSecondaryButton: true,
                  rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                  onPress: () {
                    Clipboard.setData(
                      ClipboardData(text: _participantsCode),
                    );
                    // Navigator.pop(context);
                    _showCenterFlash(
                      'Participant',
                      position: FlashPosition.top,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCenterFlash(
    String text, {
    FlashPosition position = FlashPosition.center,
    Alignment alignment,
  }) {
    showFlash(
      context: context,
      duration: Duration(seconds: 1),
      builder: (_, controller) {
        return FlashMessage(
          controller: controller,
          backgroundColor: heavyBlack,
          position: position,
          alignment: alignment,
          style: FlashStyle.grounded,
          enableDrag: false,
          onTap: () => controller.dismiss(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultTextStyle(
              style: TextStyle(color: Colors.white),
              child: Text(
                '$text Code Copied!',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
