import 'package:flutter/material.dart';

import 'ui/home/home_module.dart';

// import 'app_bloc.dart';
// import 'app_module.dart';

class AppWidget extends StatelessWidget {
  final appName = 'HackTrack';
  @override
  Widget build(BuildContext context) {
    // final AppBloc bloc = AppModule.to.bloc();
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeModule(),
      // home: StreamBuilder<String>(
      //   stream: bloc.tokenController,
      //   builder: (context, snapshot) {
      //     // if (snapshot.hasData)
      //     //   return HomeModule();
      //     // else
      //     //   return LoginModule();
      //   },
      // ),
    );
  }
}
