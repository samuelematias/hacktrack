import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'shared/app_preferences.dart';
import 'shared/locator.dart';
import 'themes/color_palette.dart';
import 'themes/text/accent_text_theme.dart';
import 'themes/text/generic_text_theme.dart';
import 'ui/mentor/mentor_module.dart';
import 'ui/start/start_module.dart';
import 'ui/status/status_module.dart';
import 'util/routes.dart';

class AppWidget extends StatelessWidget {
  final appName = 'HackTrack';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GenericTextTheme(),
        accentTextTheme: AccentTextTheme(),
        cursorColor: black,
        cupertinoOverrideTheme: CupertinoThemeData(primaryColor: black),
      ),
      home: _handlePageToShow(),
      onGenerateRoute: (RouteSettings settings) {
        return Routes(
          context: context,
          settings: settings,
        );
      },
    );
  }

  Widget _handlePageToShow() {
    var storageService = locator<AppPreferencesService>();
    if (storageService.isUserLogged()) {
      if (storageService.isMentor()) {
        return MentorModule();
      } else {
        return StatusModule();
      }
    } else {
      return StartModule();
    }
  }
}
