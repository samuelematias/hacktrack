import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'create_bloc.dart';
import 'create_room_page.dart';

class StartModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => CreateBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => CreateRoomPage();

  static Inject get to => Inject<StartModule>.of();
}
