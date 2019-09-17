import 'package:flutter/material.dart';

import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/p/p1.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../widget/empty_appbar.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_button.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: _bodyWidget(context),
      ),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return SafeArea(
      child: Container(
        height: Metrics.ph(context, 90),
        padding: EdgeInsets.all(space_golden_dream),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Icon(
                Icons.computer,
                color: purple,
                size: space_magic_mint,
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(space_spring_green),
                  child: H1(
                    text:
                        "Welcome to HackTrack, the ultimate hackathon manager.",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: space_fire_bush,
                    top: space_golden_dream,
                  ),
                  child: P1(
                    text:
                        "Bring every status report to a real time platform, shared by mentors and participants during the event.",
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                PrimaryButton(
                  label: "Create your Hackathon",
                  onPress: () =>
                      Navigator.of(context).pushNamed(RoutesNames.createRoom),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: space_dodger_blue,
                  ),
                  child: SecondaryButton(
                    label: "Join a Hackathon",
                    onPress: () =>
                        Navigator.of(context).pushNamed(RoutesNames.join),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyAppBarWidget {}
