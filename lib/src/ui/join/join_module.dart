import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../app_module.dart';
import '../../shared/custom_dio/custom_dio.dart';
import 'join_bloc.dart';
import 'join_page.dart';
import 'join_repository.dart';

class JoinModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => JoinBloc(JoinModule.to.getDependency<JoinRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => JoinRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  Widget get view => JoinPage();

  static Inject get to => Inject<JoinModule>.of();
}
