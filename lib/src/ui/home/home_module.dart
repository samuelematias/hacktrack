import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../home/home_bloc.dart';
import '../home/home_screen.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomeScreen();

  static Inject get to => Inject<HomeModule>.of();
}
