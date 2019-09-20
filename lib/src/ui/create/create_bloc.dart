import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

class CreateBloc extends BlocBase {
  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  StreamController<String> _identifierStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _hackathonNameStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _validateStreamController =
      new StreamController<String>.broadcast();

  Function(Object) get addIdentifier => _identifierStreamController.sink.add;

  Stream<Object> get getIdentifier => _identifierStreamController.stream;

  Function(Object) get addHackathonName =>
      _hackathonNameStreamController.sink.add;

  Stream<Object> get getHackathonName => _hackathonNameStreamController.stream;

  Function(Object) get addValidate => _validateStreamController.sink.add;

  Stream<Object> get getValidate => _validateStreamController.stream;

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _identifierStreamController?.close();
    _hackathonNameStreamController?.close();
    _validateStreamController?.close();
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

  validateButton(String identifier, String hackathonName) {
    final bool identifierIsValid = identifier.isNotEmpty ? true : false;
    final bool hackathonNameIsValid = hackathonName.isNotEmpty ? true : false;

    addValidate(identifierIsValid && hackathonNameIsValid ? "ok" : "nok");
  }
}
