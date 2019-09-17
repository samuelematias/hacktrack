import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'join_bloc.dart';
import 'join_page.dart';

class JoinModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => JoinBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => JoinPage();

  static Inject get to => Inject<JoinModule>.of();
}
