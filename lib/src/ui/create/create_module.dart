import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../app_module.dart';
import '../../shared/custom_dio/custom_dio.dart';
import 'create_bloc.dart';
import 'create_hackathon_page.dart';
import 'create_repository.dart';

class CreateModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) =>
            CreateBloc(CreateModule.to.getDependency<CreateRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => CreateRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  Widget get view => CreateHackathonPage();

  static Inject get to => Inject<CreateModule>.of();
}
