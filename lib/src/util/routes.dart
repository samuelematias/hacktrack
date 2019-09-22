import 'package:flutter/material.dart';

import '../ui/create/create_codes_page.dart';
import '../ui/create/create_module.dart';
import '../ui/join/join_module.dart';
import '../ui/mentor/mentor_module.dart';
import '../ui/mentor/mentor_onboarding_page.dart';
import '../ui/profile/profile_module.dart';
import '../ui/start/start_module.dart';
import '../ui/status/status_module.dart';
import '../ui/team/create_team_page.dart';
import '../ui/team/team_module.dart';
import '../ui/team/team_page.dart';

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
              case RoutesNames.createHackathon:
                return CreateModule();
                break;
              case RoutesNames.createCodes:
                return CreateCodesPage();
                break;
              case RoutesNames.createProfile:
                // CreateProfilePageArguments arguments = settings.arguments;
                return ProfileModule();
                break;
              case RoutesNames.chooseTeam:
                return TeamModule();
                break;
              case RoutesNames.createTeam:
                return CreateTeamPage();
                break;
              case RoutesNames.team:
                return TeamPage();
                break;
              case RoutesNames.mentorOnboarding:
                return MentorOnboardingPage();
                break;
              case RoutesNames.mentorDashboard:
                return MentorModule();
                break;
              case RoutesNames.statusUpdate:
                return StatusModule();
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
  static const String createHackathon = '/create/hackathon';
  static const String createCodes = '/create/codes';
  static const String createProfile = '/create/profile';
  static const String chooseTeam = '/teams';
  static const String createTeam = '/teams/create';
  static const String team = '/team';
  static const String mentorOnboarding = '/mentor/onboarding';
  static const String mentorDashboard = '/mentor/dashboard';
  static const String statusUpdate = '/status';
}
