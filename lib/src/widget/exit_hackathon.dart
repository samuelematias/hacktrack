import 'package:flutter/material.dart';

import '../shared/app_preferences.dart';
import '../shared/locator.dart';
import '../themes/color_palette.dart';
import '../themes/spacing/linear_scale.dart';
import '../themes/text/typography/h/h4.dart';
import '../ui/start/start_page.dart';
import 'primary_button.dart';
import 'secondary_button.dart';

class ExitHackathon extends StatelessWidget {
  static var storageService = locator<AppPreferencesService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: space_conifer,
            top: space_golden_dream,
            right: space_conifer,
            bottom: space_heliotrope,
          ),
          child: H4(
            text: "Are your sure you want to exit the hackathon?",
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
