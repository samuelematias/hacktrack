import 'package:flutter/material.dart';

import '../ui/create/create_codes_page.dart';
import '../ui/create/create_profile_page.dart';
import '../ui/create/create_room_page.dart';
import '../ui/join/join_module.dart';
import '../ui/start/start_module.dart';
import '../ui/team/choose_team_page.dart';

class Routes extends MaterialPageRoute {
  Routes({
    @required BuildContext context,
    @required RouteSettings settings,
  }) : super(
          settings: settings,
          // ignore: missing_return
          builder: (BuildContext context) {
            switch (settings.name) {
              case RoutesNames.start:
                return StartModule();
                break;
              case RoutesNames.join:
                return JoinModule();
                break;
              case RoutesNames.createRoom:
                return CreateRoomPage();
                break;
              case RoutesNames.createCodes:
                return CreateCodesPage();
                break;
              case RoutesNames.createProfile:
                return CreateProfilePage();
                break;
              case RoutesNames.chooseTeam:
                return ChooseTeamPage();
                break;
              default:
                break;
            }
          },
        );
}

class RoutesNames {
  static const String root = '/';
  static const String start = '/start';
  static const String join = '/join';
  static const String createRoom = '/create/room';
  static const String createCodes = '/create/codes';
  static const String createProfile = '/create/profile';
  static const String chooseTeam = '/teams';
}
