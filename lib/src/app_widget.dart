import 'package:flutter/material.dart';

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
      ),
      home: HomeModule(),
    );
  }
}
