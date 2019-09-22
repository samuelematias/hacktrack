import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/team_model.dart';
import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/custom_dialog.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../widget/card_track.dart';
import '../../widget/content_card.dart';
import '../../widget/custom_progress_indicator.dart';
import '../../widget/error_alert.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_appbar.dart';
import '../../widget/secondary_button.dart';
import '../start/start_page.dart';
import 'team_bloc.dart';
import 'team_module.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  var bloc = TeamModule.to.getBloc<TeamBloc>();
  static var storageService = locator<AppPreferencesService>();

  @override
  void initState() {
    _init();
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  void _init() {
    bloc.getTeamTrack();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
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
        customHeaderLeft: true,
        showHeaderRight: true,
        onClickHeaderRight: () => Navigator.of(context).pushNamed(
          RoutesNames.statusUpdate,
        ),
        onClickCustomHeaderLeft: () =>
            CustomDialog.show(context, _buildDialogContent(context), 110),
      ),
      body: SingleChildScrollView(
        child: _bodyWidget(context, bloc),
      ),
    );
  }

  Widget _bodyWidget(BuildContext context, TeamBloc bloc) {
    List<Map<String, dynamic>> contents = [
      {
        "photo":
            "https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg",
        'title': 'Content 1',
        "link": "https://flutter.dev"
      },
      {
        "photo":
            "https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg",
        'title': 'Content 2',
        "link": "https://flutter.dev"
      },
      {
        "photo":
            "https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg",
        'title': 'Content 3',
        "link": "https://flutter.dev"
      },
      {
        "photo":
            "https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg",
        'title': 'Content 4',
        "link": "https://flutter.dev"
      },
      {
        "photo":
            "https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg",
        'title': 'Content 5',
        "link": "https://flutter.dev"
      },
    ];

    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: space_dodger_blue,
                    top: space_golden_dream,
                    bottom: space_spring_green,
                  ),
                  child: H1(
                    text: "${storageService.getTeamStage()} PHASE",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: space_dodger_blue,
                    top: space_dodger_blue,
                  ),
                  child: H4(
                    text: "Helpful content for this phase:",
                  ),
                ),
                _buildContentHorizontalList(context, contents),
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
                        : !empyList
                            ? buildTrackList(context, snapshot)
                            : Container();
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(space_geraldine),
              child: Column(
                children: <Widget>[
                  H4(
                    text: "When you finish your ideation, press the",
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.refresh,
                        color: purple,
                      ),
                      H4(
                        text: "button to move to the next phase.",
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
    var files =
        item.files == null ? [] : item.files.length > 0 ? item.files[0] : [];
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
          top: isTheFirstPositionOfArray ? 0.0 : space_golden_dream,
        ),
        child: CardTrack(
          photo: files,
          stage: item.stage,
          status: item.status,
          updatedAt: item.updatedAt,
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
}
