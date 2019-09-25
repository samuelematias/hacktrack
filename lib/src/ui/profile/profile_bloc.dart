import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/user_model.dart';
import '../../util/regex.dart';
import '../create/create_repository.dart';

class ProfileBloc extends BlocBase {
  final CreateRepository repo;

  ProfileBloc(this.repo);

  String userName;
  String userEmail;
  String userRole;
  String userBio;

  var _isShowLoading = BehaviorSubject<bool>();

  var userPost = BehaviorSubject<UserModel>();
  UserModel get userPostValue => userPost.value;
  Sink<UserModel> get userPostIn => userPost.sink;

  static var storageService = locator<AppPreferencesService>();

  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  StreamController<String> _userNameStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _userEmailStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _userRoleStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _userBioStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _validateCreateProfileStreamController =
      new StreamController<String>.broadcast();

  Function(String) get addUserName => _userNameStreamController.sink.add;

  Stream<String> get getUserName => _userNameStreamController.stream;

  Function(String) get addUserEmail => _userEmailStreamController.sink.add;

  Stream<String> get getUserEmail => _userEmailStreamController.stream;

  Function(String) get addUserRole => _userRoleStreamController.sink.add;

  Stream<String> get getUserRole => _userRoleStreamController.stream;

  Function(String) get addUserBio => _userBioStreamController.sink.add;

  Stream<String> get getUserBio => _userBioStreamController.stream;

  Function(String) get addValidateCreateProfile =>
      _validateCreateProfileStreamController.sink.add;

  Stream<String> get getValidateCreateProfile =>
      _validateCreateProfileStreamController.stream;

  Stream<bool> get isShowLoading => _isShowLoading.stream;

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _userNameStreamController?.close();
    _userEmailStreamController?.close();
    _userRoleStreamController?.close();
    _userBioStreamController?.close();
    _validateCreateProfileStreamController?.close();
    _isShowLoading?.close();
    userPost?.close();
  }

  void createUser() async {
    try {
      String code = storageService.getJoinCode();
      var isMentorCode =
          code.contains('mentor') || storageService.isCreateHackathonSuccess();
      _isShowLoading.add(true);
      var response = await repo.createUser(UserModel(
        hackathon: storageService.getHackathonId(),
        name: userName,
        email: userEmail,
        role: storageService.isCreateHackathonSuccess() ? 'Owner' : userRole,
        isMentor: isMentorCode,
        bio: userBio,
      ).toJson());

      if (response.id != null) {
        _isShowLoading.add(false);
        storageService.setIsUserLogged(isMentorCode);
        storageService.setIsMentor(isMentorCode);
        storageService.setUserId(response.id);
        userPostIn.add(response);
      } else {
        _isShowLoading.add(false);
        userPost.addError(404);
      }
    } catch (e) {
      _isShowLoading.add(false);
      userPost.addError(404);
    }
  }

  updateUserName(String text) {
    addUserName(text.isEmpty ? null : text.trim().length > 0 ? text : null);
  }

  updateUserEmail(String text) {
    Iterable<Match> matches = Regex.emailRegex(text);
    if (matches.isNotEmpty) {
      addUserEmail(text.isEmpty ? null : text.trim().length > 0 ? text : null);
    } else {
      addUserEmail(null);
    }
  }

  updateUserRole(String text) {
    addUserBio(text.isEmpty ? null : text.trim().length > 0 ? text : null);
  }

  updateUserBio(String text) {
    addUserBio(text.isEmpty ? null : text.trim().length > 0 ? text : null);
  }

  validateCreateProfileButton(
    String name,
    String email,
    String role,
    String bio,
  ) {
    Iterable<Match> matches = Regex.emailRegex(email);
    final bool nameIsValid =
        name.isEmpty ? false : name.trim().length > 0 ? true : false;
    final bool emailIsValid = email.isEmpty
        ? false
        : email.trim().length == 0 ? false : matches.isNotEmpty ? true : false;
    final bool roleIsValid =
        role.isEmpty ? false : role.trim().length > 0 ? true : false;
    final bool bioIsValid =
        bio.isEmpty ? false : bio.trim().length > 0 ? true : false;
    addValidateCreateProfile(
      nameIsValid && emailIsValid && roleIsValid && bioIsValid ? "ok" : "nok",
    );
  }
}
