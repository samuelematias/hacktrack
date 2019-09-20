import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

import '../../util/regex.dart';

class CreateBloc extends BlocBase {
  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  StreamController<String> _identifierStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _hackathonNameStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _validateCreateHackathonStreamController =
      new StreamController<String>.broadcast();

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

  Function(String) get addIdentifier => _identifierStreamController.sink.add;

  Stream<String> get getIdentifier => _identifierStreamController.stream;

  Function(String) get addHackathonName =>
      _hackathonNameStreamController.sink.add;

  Stream<String> get getHackathonName => _hackathonNameStreamController.stream;

  Function(String) get addValidateCreateHackathon =>
      _validateCreateHackathonStreamController.sink.add;

  Stream<String> get getValidateCreateHackathon =>
      _validateCreateHackathonStreamController.stream;

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

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _identifierStreamController?.close();
    _hackathonNameStreamController?.close();
    _validateCreateHackathonStreamController?.close();
    _userNameStreamController?.close();
    _userEmailStreamController?.close();
    _userRoleStreamController?.close();
    _userBioStreamController?.close();
    _validateCreateProfileStreamController?.close();
  }

  updateIdentifier(String text) {
    addIdentifier(text.isEmpty ? null : text.trim().length > 0 ? text : null);
    //handle errors:
    // (text == null || text == "")
    //     ? _textController.sink.addError("Invalid value entered!")
    //     : _textController.sink.add(text);
  }

  updateHackathonName(String text) {
    addHackathonName(
      text.isEmpty ? null : text.trim().length > 0 ? text : null,
    );
  }

  validateCreateHackathonButton(String identifier, String hackathonName) {
    final bool identifierIsValid = identifier.isEmpty
        ? false
        : identifier.trim().length > 0 ? true : false;
    final bool hackathonNameIsValid = hackathonName.isEmpty
        ? false
        : hackathonName.trim().length > 0 ? true : false;

    addValidateCreateHackathon(
        identifierIsValid && hackathonNameIsValid ? "ok" : "nok");
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
    addUserRole(text.isEmpty ? null : text.trim().length > 0 ? text : null);
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
