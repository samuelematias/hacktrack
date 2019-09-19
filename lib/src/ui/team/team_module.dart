import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'choose_team_page.dart';
import 'team_bloc.dart';

class TeamModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => TeamBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ChooseTeamPage();

  static Inject get to => Inject<TeamModule>.of();
}
