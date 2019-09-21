import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../themes/color_palette.dart';
import '../../themes/spacing/linear_scale.dart';
import '../../themes/text/typography/h/h1.dart';
import '../../util/metrics.dart';
import '../../util/routes.dart';
import '../../widget/primary_button.dart';
import '../../widget/row_info.dart';
import '../../widget/secondary_appbar.dart';

class CreateCodesPage extends StatefulWidget {
  static var storageService = locator<AppPreferencesService>();

  @override
  _CreateCodesPageState createState() => _CreateCodesPageState();
}

class _CreateCodesPageState extends State<CreateCodesPage> {
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
        pageTitle: CreateCodesPage.storageService.getHackathonName(),
        context: context,
        hideHeaderLeft: true,
      ),
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    double leftOverFlow = 20.0;
    double rightOverFlow = 20.0;
    double bottomOverFlow = 20.0;
    String _mentorsCode = CreateCodesPage.storageService.getMentorCode();
    String _participantsCode =
        CreateCodesPage.storageService.getParticipantCode();

    return SafeArea(
      child: Container(
        width: Metrics.fullWidth(context),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
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
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  left: leftOverFlow,
                  right: rightOverFlow,
                  bottom: bottomOverFlow,
                  child: PrimaryButton(
                      label: "Next",
                      onPress: () {
                        Navigator.of(context)
                            .pushNamed(RoutesNames.createProfile);
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
