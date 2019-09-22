import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../app_module.dart';
import '../../shared/custom_dio/custom_dio.dart';
import 'choose_team_page.dart';
import 'team_bloc.dart';
import 'team_repository.dart';

class TeamModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => TeamBloc(TeamModule.to.getDependency<TeamRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => TeamRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  Widget get view => ChooseTeamPage();

  static Inject get to => Inject<TeamModule>.of();
}
