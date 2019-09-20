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
    addIdentifier(text.isNotEmpty ? text : null);
    //check error:
    // (text == null || text == "")
    //     ? _textController.sink.addError("Invalid value entered!")
    //     : _textController.sink.add(text);
  }

  updateHackathonName(String text) {
    addHackathonName(text.isNotEmpty ? text : null);
  }

  validateCreateHackathonButton(String identifier, String hackathonName) {
    final bool identifierIsValid = identifier.isNotEmpty ? true : false;
    final bool hackathonNameIsValid = hackathonName.isNotEmpty ? true : false;

    addValidateCreateHackathon(
        identifierIsValid && hackathonNameIsValid ? "ok" : "nok");
  }

  updateUserName(String text) {
    addUserName(text.isNotEmpty ? text : null);
  }

  updateUserEmail(String text) {
    Iterable<Match> matches = Regex.emailRegex(text);
    if (matches.isNotEmpty) {
      addUserEmail(text.isNotEmpty ? text : null);
    } else {
      addUserEmail(null);
    }
  }

  updateUserRole(String text) {
    addUserRole(text.isNotEmpty ? text : null);
  }

  updateUserBio(String text) {
    addUserBio(text.isNotEmpty ? text : null);
  }

  validateCreateProfileButton(
    String name,
    String email,
    String role,
    String bio,
  ) {
    Iterable<Match> matches = Regex.emailRegex(email);
    final bool nameIsValid = name.isNotEmpty ? true : false;
    final bool emailIsValid =
        email.isEmpty ? false : matches.isNotEmpty ? true : false;
    final bool roleIsValid = role.isNotEmpty ? true : false;
    final bool bioIsValid = bio.isNotEmpty ? true : false;

    addValidateCreateProfile(
      nameIsValid && emailIsValid && roleIsValid && bioIsValid ? "ok" : "nok",
    );
  }
}
