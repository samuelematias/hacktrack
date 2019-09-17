import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'themes/text/accent_text_theme.dart';
import 'themes/text/generic_text_theme.dart';
import 'ui/start/start_module.dart';
import 'util/routes.dart';

class AppWidget extends StatelessWidget {
  final appName = 'HackTrack';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GenericTextTheme(),
        accentTextTheme: AccentTextTheme(),
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
