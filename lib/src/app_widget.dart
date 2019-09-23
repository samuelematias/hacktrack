import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hacktrack/src/shared/app_preferences.dart';
import 'package:hacktrack/src/shared/locator.dart';

import 'themes/color_palette.dart';
import 'themes/text/accent_text_theme.dart';
import 'themes/text/generic_text_theme.dart';
import 'ui/start/start_module.dart';
import 'util/routes.dart';

class AppWidget extends StatelessWidget {
  final appName = 'HackTrack';
  @override
  Widget build(BuildContext context) {
    // var storageService = locator<AppPreferencesService>();
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
      home: StartModule(),
      onGenerateRoute: (RouteSettings settings) {
        return Routes(
          context: context,
          settings: settings,
        );
      },
    );
  }
}
