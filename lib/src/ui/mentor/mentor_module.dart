import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../app_module.dart';
import '../../shared/custom_dio/custom_dio.dart';
import '../team/team_repository.dart';
import 'mentor_bloc.dart';
import 'mentor_dashboard._page.dart';

class MentorModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc(
            (i) => MentorBloc(MentorModule.to.getDependency<TeamRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => TeamRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  Widget get view => MentorDashboardPage();

  static Inject get to => Inject<MentorModule>.of();
}
