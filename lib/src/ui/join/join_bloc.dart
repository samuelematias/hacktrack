import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class JoinBloc extends BlocBase {
  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  StreamController<String> _joinCodeStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _validateJoinStreamController =
      new StreamController<String>.broadcast();

  Function(String) get addJoinCode => _joinCodeStreamController.sink.add;

  Stream<String> get getJoinCode => _joinCodeStreamController.stream;

  Function(String) get addValidateJoin =>
      _validateJoinStreamController.sink.add;

  Stream<String> get getValidateJoin => _validateJoinStreamController.stream;

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _joinCodeStreamController?.close();
    _validateJoinStreamController?.close();
  }

  updateJoinCode(String text) {
    addJoinCode(
      text.isEmpty ? null : text.trim().length > 0 ? text : null,
    );
    //handle errors:
    // (text == null || text == "")
    //     ? _textController.sink.addError("Invalid value entered!")
    //     : _textController.sink.add(text);
  }

  validateJoinButton(String joinCode) {
    final bool joinCodeIsValid =
        joinCode.isEmpty ? false : joinCode.trim().length > 0 ? true : false;

    addValidateJoin(joinCodeIsValid ? "ok" : "nok");
  }
}
