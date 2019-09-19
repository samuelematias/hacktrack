import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'mentor_bloc.dart';
import 'mentor_dashboard._page.dart';

class MentorModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => MentorBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => MentorDashboardPage();

  static Inject get to => Inject<MentorModule>.of();
}
