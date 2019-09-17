import 'package:flutter/material.dart';

import 'themes/text/accent_text_theme.dart';
import 'themes/text/generic_text_theme.dart';
import 'ui/home/home_module.dart';

class AppWidget extends StatelessWidget {
  final appName = 'HackTrack';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GenericTextTheme(),
        accentTextTheme: AccentTextTheme(),
      ),
      home: HomeModule(),
    );
  }
}
