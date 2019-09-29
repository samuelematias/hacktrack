import 'package:flutter/material.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../themes/images_gallery.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../themes/text/typography/p/p5.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../widget/empty_appbar.dart';
import '../../widget/primary_button.dart';
import '../../widget/secondary_button.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  static var storageService = locator<AppPreferencesService>();

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
              child: Image(
                image: AssetImage(logo),
                fit: BoxFit.contain,
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
                    left: space_spring_green,
                    top: space_golden_dream,
                  ),
                  child: P5(
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
                    onPress: () {
                      storageService.clear();
                      Navigator.of(context)
                          .pushNamed(RoutesNames.createHackathon);
                    }),
                Padding(
                  padding: EdgeInsets.only(
                    top: space_dodger_blue,
                  ),
                  child: SecondaryButton(
                      label: "Join a Hackathon",
                      onPress: () {
                        storageService.clear();
                        Navigator.of(context).pushNamed(RoutesNames.join);
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
