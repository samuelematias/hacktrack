import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class TeamBloc extends BlocBase {
  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  StreamController<String> _teamNameStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _validateCreateTeamStreamController =
      new StreamController<String>.broadcast();

  Function(String) get addTeamName => _teamNameStreamController.sink.add;

  Stream<String> get getTeamName => _teamNameStreamController.stream;

  Function(String) get addValidateCreateTeam =>
      _validateCreateTeamStreamController.sink.add;

  Stream<String> get getValidateCreateTeam =>
      _validateCreateTeamStreamController.stream;

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _teamNameStreamController?.close();
    _validateCreateTeamStreamController?.close();
  }

  updateTeamName(String text) {
    addTeamName(
      text.isEmpty ? null : text.trim().length > 0 ? text : null,
    );
    //handle errors:
    // (text == null || text == "")
    //     ? _textController.sink.addError("Invalid value entered!")
    //     : _textController.sink.add(text);
  }

  validateCreateTeamButton(String teamName) {
    final bool teamNameIsValid =
        teamName.isEmpty ? false : teamName.trim().length > 0 ? true : false;

    addValidateCreateTeam(teamNameIsValid ? "ok" : "nok");
  }
}
