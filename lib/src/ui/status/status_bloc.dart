import 'dart:async';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';

class StatusBloc extends BlocBase {
  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  StreamController<String> _commentsStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _validateUpdateStreamController =
      new StreamController<String>.broadcast();

  StreamController<File> _photoOneStreamController =
      new StreamController<File>.broadcast();

  Function(String) get addComment => _commentsStreamController.sink.add;

  Stream<String> get getComment => _commentsStreamController.stream;

  Function(String) get addValidateUpdate =>
      _validateUpdateStreamController.sink.add;

  Stream<String> get getValidateUpdate =>
      _validateUpdateStreamController.stream;

  Function(File) get addPhotoOne => _photoOneStreamController.sink.add;

  Stream<File> get getPhotoOne => _photoOneStreamController.stream;

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _commentsStreamController?.close();
    _validateUpdateStreamController?.close();
    _photoOneStreamController?.close();
  }

  updatePhotoOne(File photo) {
    //On iOS, the Bloc dont add on stream.
    addPhotoOne(photo);
    //handle errors:
    // (text == null || text == "")
    //     ? _textController.sink.addError("Invalid value entered!")
    //     : _textController.sink.add(text);
  }

  updateComment(String text) {
    addComment(
      text.isEmpty ? null : text.trim().length > 0 ? text : null,
    );
    //handle errors:
    // (text == null || text == "")
    //     ? _textController.sink.addError("Invalid value entered!")
    //     : _textController.sink.add(text);
  }

  validateUpdateButton(String comments) {
    final bool commentsIsValid =
        comments.isEmpty ? false : comments.trim().length > 0 ? true : false;

    addValidateUpdate(commentsIsValid ? "ok" : "nok");
  }
}
