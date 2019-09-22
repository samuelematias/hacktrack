import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/app_preferences.dart';
import '../../shared/locator.dart';
import '../../shared/models/team_model.dart';
import '../team/team_repository.dart';

class MentorBloc extends BlocBase {
  final TeamRepository repo;

  MentorBloc(this.repo);

  String teamId;
  String teamName;

  static var storageService = locator<AppPreferencesService>();

  var _isShowLoading = BehaviorSubject<bool>();

  var getTeams = BehaviorSubject<List<TeamModel>>();
  Sink<List<TeamModel>> get getTeamsIn => getTeams.sink;
  Observable<List<TeamModel>> get getTeamsOut => getTeams.stream;

  var getTracks = BehaviorSubject<List<TeamModel>>();
  Sink<List<TeamModel>> get getTracksIn => getTracks.sink;
  Observable<List<TeamModel>> get getTracksOut => getTracks.stream;

  StreamController<int> _streamController =
      new StreamController<int>.broadcast();

  Stream<bool> get isShowLoading => _isShowLoading.stream;

  @override
  void dispose() {
    super.dispose();
    _streamController?.close();
    _isShowLoading?.close();
    getTeams?.close();
    getTracks?.close();
  }

  void trigger2Queries() {
    _isShowLoading.add(true);
  }

  void listTeams() async {
    try {
      _isShowLoading.add(true);
      var response = await repo.getTeams(
          TeamModel(hackaId: storageService.getHackathonId()).toJson());
      if (response.length > 0) {
        _isShowLoading.add(false);
        getTeamsIn.add(response);
        // getTeamTrack(teamId: response.id);
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
}
