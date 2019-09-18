import 'package:flutter/material.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h4.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../widget/row_info.dart';
import '../../widget/secondary_appbar.dart';
import '../../widget/secondary_button.dart';

class ChooseTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: SecondaryAppBar(
        pageTitle: "Shawee",
        context: context,
      ),
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    // double leftOverFlow = 10.0;
    // double rightOverFlow = 10.0;
    // double bottomOverFlow = 20.0;

    return SafeArea(
      child: Container(
        width: Metrics.fullWidth(context),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
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
                    child: buildTeamsList(context),
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
              ),
            ),
            // Stack(
            //   children: <Widget>[
            //     Positioned(
            //       left: leftOverFlow,
            //       right: rightOverFlow,
            //       bottom: bottomOverFlow,
            //       child: SecondaryButton(
            //         label: "Create team",
            //         onPress: () {},
            //       ),
            //     ),
            //   ],
            // )
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
        icon: Icons.star,
        iconColor: darkGrey,
        circleColor: heavyGrey,
        title: key['title'],
        subTitle: key['subTitle'],
        buttonLabel: "Join",
        onPress: () {},
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}