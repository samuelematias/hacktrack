import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/hackathon_model.dart';
import 'create_repository.dart';

class CreateBloc extends BlocBase {
  final CreateRepository repo;

  CreateBloc(this.repo);

  String identifier;
  String hackathonName;

  var _isShowLoading = BehaviorSubject<bool>();

  var post = BehaviorSubject<HackathonModel>();
  HackathonModel get postValue => post.value;
  Sink<HackathonModel> get postIn => post.sink;

  static var storageService = locator<AppPreferencesService>();

  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  StreamController<String> _identifierStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _hackathonNameStreamController =
      new StreamController<String>.broadcast();

  StreamController<String> _validateCreateHackathonStreamController =
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

  Stream<bool> get isShowLoading => _isShowLoading.stream;

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _identifierStreamController?.close();
    _hackathonNameStreamController?.close();
    _validateCreateHackathonStreamController?.close();
    _isShowLoading?.close();
    post?.close();
  }

  void createHackathon() async {
    try {
      _isShowLoading.add(true);
      var response = await repo.createHackathon(
          HackathonModel(identifier: identifier, name: hackathonName).toJson());
      postIn.add(response);
      if (response.identifier != null) {
        _isShowLoading.add(false);
        storageService.setCreateHackathonSuccess(true);
        postIn.add(response);
        storageService.setHackathonId(response.id);
        storageService.setHackathonIdentifier(identifier);
        storageService.setHackathonName(hackathonName);
        storageService.setMentorCode(response.mentorLink);
        storageService.setParticipantCode(response.participantLink);
        storageService.setIsMentor(true);
      } else {
        _isShowLoading.add(false);
        storageService.setCreateHackathonSuccess(false);
        post.addError(226);
      }
    } catch (e) {
      _isShowLoading.add(false);
      storageService.setCreateHackathonSuccess(false);
      post.addError(404);
    }
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
}
