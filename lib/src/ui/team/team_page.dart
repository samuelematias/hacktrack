import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/h/h4.dart';
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
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: space_golden_dream,
                bottom: space_spring_green,
              ),
              child: H1(
                text: "IDEATION PHASE",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: space_dodger_blue,
              ),
              child: H4(
                text: "Helpful content for this phase:",
              ),
            ),
            // GridView.count(
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   crossAxisCount: 2,
            //   padding: EdgeInsets.all(8.0),
            //   crossAxisSpacing: 8.0,
            //   mainAxisSpacing: 5.0,
            //   children: _buildContentList(contents),
            // ),
            Container(
              // margin: EdgeInsets.only(
              //   left: space_dodger_blue,
              // ),
              child: _buildContentHorizontalList(context, contents),
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

  // List<Widget> _buildContentList(List<Map<String, dynamic>> contents) {
  //   return contents.map((data) => _buildContentListItem(data)).toList();
  // }

  // Widget _buildContentListItem(Map<String, dynamic> data) {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       top: space_dodger_blue,
  //     ),
  //     child: GestureDetector(
  //       onTap: () => _launchLink(data["link"]),
  //       child: ContentCard(
  //         photo: data["photo"],
  //         title: data["title"],
  //       ),
  //     ),
  //   );
  // }

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
}
