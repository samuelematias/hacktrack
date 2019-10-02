import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/helper_contents.dart';
import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/team_model.dart';
import '../../shared/screen_arguments.dart';
import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/custom_dialog.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../util/slide_right_transition.dart';
import '../../widget/card_track.dart';
import '../../widget/content_card.dart';
import '../../widget/custom_progress_indicator.dart';
import '../../widget/error_alert.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_appbar.dart';
import '../../widget/secondary_button.dart';
import '../mentor/mentor_module.dart';
import '../start/start_page.dart';
import 'status_bloc.dart';
import 'status_module.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  var bloc = StatusModule.to.getBloc<StatusBloc>();
  static var storageService = locator<AppPreferencesService>();
  StreamSubscription listenTeamTrackResponseLoading;
  bool isLoading = false;
  bool isMentor = storageService.isMentor();

  @override
  void initState() {
    _init();
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  void _init() {
    bloc.getTeamTrack();
    listenTeamTrackResponseLoading = bloc.isShowLoading.listen((data) {
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
    BackButtonInterceptor.remove(myInterceptor);
    listenTeamTrackResponseLoading.cancel();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    return true; // Disable Android Backbutton.
  }

  @override
  Widget build(BuildContext context) {
    StatusUpdateArguments arguments =
        StatusUpdateArguments(onSuccess: bloc.getTeamTrack);

    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: !isMentor
            ? storageService.getHackathonName()
            : storageService.getTeamName(),
        context: context,
        customHeaderLeft: !storageService.isMentor() ? true : false,
        showHeaderRight: true,
        onClickHeaderRight: () => _init(),
        onClickBackButton: () {
          Navigator.of(
            context,
          ).pushAndRemoveUntil(
              SlideRightRoute(
                widget: MentorModule(),
              ),
              (Route<dynamic> route) => false);
        },
        onClickCustomHeaderLeft: () =>
            CustomDialog.show(context, _buildDialogContent(context), 110),
      ),
      body: SingleChildScrollView(
        child: _bodyWidget(context, bloc),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          RoutesNames.statusUpdate,
          arguments: arguments,
        ),
        child: Icon(Icons.add),
        backgroundColor: purple,
      ),
    );
  }

  Widget _bodyWidget(BuildContext context, StatusBloc bloc) {
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Metrics.fullWidth(context),
                  alignment:
                      !isMentor ? Alignment.centerLeft : Alignment.center,
                  padding: EdgeInsets.only(
                    left: space_dodger_blue,
                    top: space_golden_dream,
                    bottom: space_spring_green,
                  ),
                  child: H1(
                    text: "${storageService.getTeamStage()} Phase",
                  ),
                ),
                !isMentor
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: space_dodger_blue,
                          top: space_dodger_blue,
                        ),
                        child: H4(
                          text: "Helpful content for this phase:",
                        ),
                      )
                    : Container(),
                !isMentor
                    ? _buildContentHorizontalList(context,
                        _handleHelperContentType(storageService.getTeamStage()))
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(
                    left: space_dodger_blue,
                    top: space_golden_dream,
                    bottom: space_spring_green,
                  ),
                  child: H1(
                    text: "TRACK",
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: space_spring_green,
              ),
              child: StreamBuilder<List<TeamModel>>(
                  stream: bloc.getTracks,
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
                            ? Container()
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
                                : buildTrackList(context, snapshot);
                  }),
            ),
            !isLoading
                ? Padding(
                    padding: EdgeInsets.all(space_geraldine),
                    child: Column(
                      children: <Widget>[
                        H4(
                          text:
                              "When you need to report your status, press the",
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: purple,
                            ),
                            H4(
                              text: "button to report",
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildContentHorizontalList(
    BuildContext context,
    List<Map<String, dynamic>> contents,
  ) {
    return Container(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: contents.length,
          itemBuilder: (context, index) {
            var key = contents.elementAt(index);
            return _buildContentHorizontalListItem(key, contents, index);
          }),
    );
  }

  Widget _buildContentHorizontalListItem(
    Map<String, dynamic> key,
    List<Map<String, dynamic>> contents,
    int index,
  ) {
    final bool isTheLastPositionOfArray = index + 1 == contents.length;
    return Padding(
      padding: EdgeInsets.only(
        top: space_dodger_blue,
        left: space_dodger_blue,
        right: isTheLastPositionOfArray ? space_dodger_blue : 0.0,
        bottom: space_dodger_blue,
      ),
      child: GestureDetector(
        onTap: () => _launchLink(key["link"]),
        child: ContentCard(
          photo: key["photo"],
          title: key["title"],
        ),
      ),
    );
  }

  _launchLink(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  Widget buildTrackList(
      BuildContext context, AsyncSnapshot<List<TeamModel>> snapshot) {
    if (snapshot.hasData) {
      return Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            TeamModel item = snapshot.data[index];
            return buildTrackListItem(
              context,
              item,
              snapshot.data,
              index,
            );
          },
        ),
      );
    } else {
      return Center(child: CustomProgressIndicator());
    }
  }

  Widget buildTrackListItem(
    BuildContext context,
    TeamModel item,
    List<TeamModel> tracks,
    int index,
  ) {
    final bool isTheFirstPositionOfArray = index == 0;
    List files =
        item.files == null ? [] : item.files.length > 0 ? item.files : [];
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
          top: isTheFirstPositionOfArray ? 0.0 : space_golden_dream,
        ),
        child: CardTrack(
          // photo: files,
          photos: files,
          stage: item.stage,
          status: item.status,
          updatedAt: item.status == 'ok'
              ? "Everything is ok with this team :)"
              : item.status == 'nok'
                  ? "This team is in trouble!"
                  : "No team updates yet!",
          updatedAtColor: item.status == 'ok'
              ? green
              : item.status == 'nok' ? red : mustard,
          about: item.comment,
          aboutColor:
              item.status == 'ok' ? green : item.status == 'nok' ? red : black,
        ),
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

  List<Map<String, dynamic>> _handleHelperContentType(String stage) {
    if (stage == 'Ideation') {
      return ideationContents;
    } else if (stage == 'Problem Definition') {
      return problemContents;
    } else if (stage == 'Validation') {
      return validationContents;
    } else if (stage == 'Solution') {
      return solutionContents;
    } else if (stage == 'Product') {
      return productContents;
    } else if (stage == 'Pitch') {
      return pitchContents;
    } else {
      return ideationContents;
    }
  }
}
