import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'status_bloc.dart';
import 'status_update_page.dart';

class StatusModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => StatusBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => StatusUpdatePage();

  static Inject get to => Inject<StatusModule>.of();
}
