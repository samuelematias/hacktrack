import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'start_bloc.dart';
import 'start_page.dart';

class StartModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => StartBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => StartPage();

  static Inject get to => Inject<StartModule>.of();
}
