import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:hacktrack/src/ui/status/uploaderS3.dart';

import '../../app_module.dart';
import '../../shared/custom_dio/custom_dio.dart';
import '../team/team_repository.dart';
import 'status_bloc.dart';
import 'team_page.dart';

class StatusModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc(
            (i) => StatusBloc(
                StatusModule.to.getDependency<TeamRepository>(), UploadToS3()),
            singleton: false),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => TeamRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  Widget get view => TeamPage();

  static Inject get to => Inject<StatusModule>.of();
}
