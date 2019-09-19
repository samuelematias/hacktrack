import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'create_bloc.dart';
import 'create_hackathon_page.dart';

class CreateModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => CreateBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => CreateHackathonPage();

  static Inject get to => Inject<CreateModule>.of();
}
