import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/custom_dialog.dart';
import '../../util/routes.dart';
import '../../widget/card_track_team.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_appbar.dart';
import '../../widget/secondary_button.dart';
import '../start/start_page.dart';

class MentorDashboardPage extends StatefulWidget {
  @override
  _MentorDashboardPageState createState() => _MentorDashboardPageState();
}

class _MentorDashboardPageState extends State<MentorDashboardPage> {
  static var storageService = locator<AppPreferencesService>();

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
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
        showHeaderRight: true,
        hideHeaderLeft: true,
        iconHeaderRight: Icons.settings,
        iconHeaderRightColor: grey,
        onClickHeaderRight: () =>
            CustomDialog.show(context, _buildDialogContent(context), 110),
      ),
      body: SingleChildScrollView(
        child: _bodyWidget(context),
      ),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    List<Map<String, dynamic>> tracks = [
      {
        'teamName': 'Team Fire',
        'teamCount': "5 participants",
        'stage': 'Ideation',
        'status': 'Need help',
        'updatedAt': 'Updated 1h ago by Pedro Bacelar',
        'about': 'Having issues to generate good ideas.',
      },
      {
        'teamName': 'Team 999',
        'teamCount': "5 participants",
        'stage': 'Product',
        'status': 'Killin it',
        'updatedAt': 'Updated 2h ago by João Ventura',
        'about':
            'Developed the UI mockups, developers working on implementing the app.',
      },
      {
        'teamName': 'Team Inovative',
        'teamCount': "5 participants",
        'stage': 'Pitch',
        'status': '',
        'updatedAt': 'Updated 6h ago by Pedro Neto',
        'about':
            'Having difficulties with the presentation time limit, we have to cut 2min.',
      },
      {
        'teamName': 'Team Inovative',
        'teamCount': "5 participants",
        'stage': 'Pitch',
        'status': '',
        'updatedAt': 'Updated 6h ago by Pedro Neto',
        'about':
            'Having difficulties with the presentation time limit, we have to cut 2min.',
      },
    ];

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          left: space_spring_green,
          top: space_geraldine,
          right: space_spring_green,
          bottom: space_heliotrope,
        ),
        child: buildTeamTrackList(tracks),
      ),
    );
  }

  Widget buildTeamTrackList(List<Map<String, dynamic>> tracks) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        var key = tracks.elementAt(index);
        return buildTeamTrackListItem(
          context,
          key,
          tracks,
          index,
        );
      },
    );
  }

  Widget buildTeamTrackListItem(
    BuildContext context,
    Map<String, dynamic> key,
    List<Map<String, dynamic>> tracks,
    int index,
  ) {
    final bool isTheFirstPositionOfArray = index == 0;
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(RoutesNames.team),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
          top: isTheFirstPositionOfArray ? 0.0 : space_golden_dream,
        ),
        child: CardTrackTeam(
          teamName: key["teamName"],
          teamCount: key["teamCount"],
          stage: key["stage"],
          // status: key["status"],
          updatedAt: key["updatedAt"],
          updatedAtColor: key["status"] == '' ? darkMustard : lightGrey,
          about: key["about"],
          aboutColor: key["status"] == 'Killin it'
              ? green
              : key["status"] == 'Need help' ? red : mustard,
          iconColor: key["status"] == 'Killin it'
              ? green
              : key["status"] == 'Need help' ? red : mustard,
          circleColor: key["status"] == 'Killin it'
              ? lightGreen
              : key["status"] == 'Need help' ? lightRed : lightMustard,
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
