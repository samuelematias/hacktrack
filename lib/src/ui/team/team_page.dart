import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../widget/card_track.dart';
import '../../widget/card_track_team.dart';
import '../../widget/content_card.dart';
import '../../widget/secondary_appbar.dart';

class TeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: "Team Fire",
        context: context,
        showHeaderLeft: true,
        hideHeaderRight: true,
        onClickBackButton: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: _bodyWidget(context),
      ),
    );
  }

  Widget _bodyWidget(BuildContext context) {
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
                    text: "PROBLEM PHASE",
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
              padding: EdgeInsets.only(
                left: space_spring_green,
                top: space_golden_dream,
                right: space_spring_green,
                bottom: space_golden_dream,
              ),
              child: CardTrackTeam(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: space_spring_green,
              ),
              child: buildTrackList(context),
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

  Widget buildTrackList(BuildContext context) {
    List<Map<String, dynamic>> tracks = [
      {
        'photo': '',
        'stage': 'Problem',
        'status': 'Need help',
        'updatedAt': 'Updated 1h ago by Pedro',
        'about': 'The team is very confused on what defines a good problem.',
      },
      {
        'photo':
            'https://ak2.picdn.net/shutterstock/videos/1014004172/thumb/1.jpg',
        'stage': 'Ideation',
        'status': 'Killin it',
        'updatedAt': 'Updated 1h ago by Pedro Bacelar',
        'about': 'Finally found a good idea! Moving to next phase.',
      },
      {
        'photo': '',
        'stage': 'Ideation',
        'status': 'Need help',
        'updatedAt': 'Updated 1h ago by Pedro Bacelar',
        'about': 'Having issues to generate good ideas.',
      },
    ];

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          var key = tracks.elementAt(index);
          return buildTrackListItem(
            context,
            key,
            tracks,
            index,
          );
        },
      ),
    );
  }

  Widget buildTrackListItem(
    BuildContext context,
    Map<String, dynamic> key,
    List<Map<String, dynamic>> tracks,
    int index,
  ) {
    final bool isTheFirstPositionOfArray = index == 0;
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
          top: isTheFirstPositionOfArray ? 0.0 : space_golden_dream,
        ),
        child: CardTrack(
          photo: key["photo"],
          stage: key["stage"],
          status: key["status"],
          updatedAt: key["updatedAt"],
          about: key["about"],
          aboutColor: key["status"] == 'Killin it' ? green : red,
        ),
      ),
    );
  }
}
