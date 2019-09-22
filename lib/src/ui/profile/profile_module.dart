import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../app_module.dart';
import '../../shared/custom_dio/custom_dio.dart';
import '../create/create_repository.dart';
import 'create_profile_page.dart';
import 'profile_bloc.dart';

class ProfileModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc(
            (i) =>
                ProfileBloc(ProfileModule.to.getDependency<CreateRepository>()),
            singleton: false),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency(
            (i) => CreateRepository(AppModule.to.getDependency<CustomDio>()))
      ];

  @override
  Widget get view => CreateProfilePage();

  static Inject get to => Inject<ProfileModule>.of();
}
