import 'dart:async';
import 'dart:core';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/team_model.dart';
import 'team_repository.dart';

class TeamBloc extends BlocBase {
  final TeamRepository repo;

  TeamBloc(this.repo);

  String teamId;
  String teamName;

  static var storageService = locator<AppPreferencesService>();

  var _isShowLoading = BehaviorSubject<bool>();

  var getTeams = BehaviorSubject<List<TeamModel>>();
  Sink<List<TeamModel>> get getTeamsIn => getTeams.sink;
  Observable<List<TeamModel>> get getTeamsOut => getTeams.stream;

  var joinTeamPost = BehaviorSubject<TeamModel>();
  TeamModel get joinTeamPostValue => joinTeamPost.value;
  Sink<TeamModel> get joinTeamPostIn => joinTeamPost.sink;

  var createTeamPost = BehaviorSubject<TeamModel>();
  TeamModel get createTeamPostValue => createTeamPost.value;
  Sink<TeamModel> get createTeamPostIn => createTeamPost.sink;

  var getTracks = BehaviorSubject<List<TeamModel>>();
  Sink<List<TeamModel>> get getTracksIn => getTracks.sink;
  Observable<List<TeamModel>> get getTracksOut => getTracks.stream;

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

  Stream<bool> get isShowLoading => _isShowLoading.stream;

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _teamNameStreamController?.close();
    _validateCreateTeamStreamController?.close();
    _isShowLoading?.close();
    getTeams?.close();
    joinTeamPost?.close();
    createTeamPost?.close();
    getTracks?.close();
  }

  void listTeams() async {
    try {
      _isShowLoading.add(true);
      var response = await repo.getTeams(
          TeamModel(hackaId: storageService.getHackathonId()).toJson());
      print('LOL? ${response.length}');
      if (response.length > 0) {
        _isShowLoading.add(false);
        getTeamsIn.add(response);
      } else {
        _isShowLoading.add(false);
        getTeams.addError(204);
      }
    } catch (e) {
      print("LOL $e");
      _isShowLoading.add(false);
      getTeams.addError(404);
    }
  }

  void joinTeam(String teamId) async {
    try {
      _isShowLoading.add(true);
      var response = await repo.joinTeam(TeamModel(
        userId: storageService.getUserId(),
        teamId: teamId,
      ).toJson());
      if (response.id != null) {
        storageService.setIsUserLogged(true);
        storageService.setTeamId(teamId);
        storageService.setTeamStage(response.stage);
        _isShowLoading.add(false);
        joinTeamPostIn.add(response);
      } else {
        _isShowLoading.add(false);
        joinTeamPost.addError(404);
      }
    } catch (e) {
      _isShowLoading.add(false);
      storageService.setCreateHackathonSuccess(false);
      joinTeamPost.addError(404);
    }
  }

  void createTeam() async {
    try {
      _isShowLoading.add(true);
      var response = await repo.createTeam(TeamModel(
        userId: storageService.getUserId(),
        hackaId: storageService.getHackathonId(),
        name: teamName,
      ).toJson());
      if (response.id != null) {
        storageService.setIsUserLogged(true);
        storageService.setTeamId(response.id);
        storageService.setTeamStage(response.stage);
        _isShowLoading.add(false);
        createTeamPostIn.add(response);
      } else {
        _isShowLoading.add(false);
        createTeamPost.addError(226);
      }
    } catch (e) {
      _isShowLoading.add(false);
      storageService.setCreateHackathonSuccess(false);
      createTeamPost.addError(404);
    }
  }

  void getTeamTrack({String teamId}) async {
    try {
      _isShowLoading.add(true);
      var response = await repo
          .getTeamTrack(TeamModel(teamId: storageService.getTeamId()).toJson());

      if (response.length > 0) {
        _isShowLoading.add(false);
        getTracksIn.add(response);
      } else {
        _isShowLoading.add(false);
        getTracks.addError(204);
      }
    } catch (e) {
      _isShowLoading.add(false);
      getTracks.addError(404);
    }
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
