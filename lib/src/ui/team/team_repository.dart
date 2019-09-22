import 'package:dio/dio.dart';

import '../../shared/custom_dio/custom_dio.dart';
import '../../shared/models/team_model.dart';

class TeamRepository {
  final CustomDio _client;

  TeamRepository(this._client);

  Future<List<TeamModel>> getTeams(Map<String, dynamic> data) async {
    try {
      var response = await _client.get("/teams?", queryParameters: data);
      return (response.data as List)
          .map((item) => TeamModel.fromJson(item))
          .toList();
    } on DioError catch (e) {
      throw (e.message);
      // throw (e.responde.data); // if the API response a error.
    }
  }

  Future<TeamModel> joinTeam(Map<String, dynamic> data) async {
    try {
      var response = await _client.post("/teams/join", data: data);
      return TeamModel.fromJson(response.data);
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<TeamModel> createTeam(Map<String, dynamic> data) async {
    try {
      var response = await _client.post("/teams", data: data);
      return TeamModel.fromJson(response.data);
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<List<TeamModel>> getTeamTrack(Map<String, dynamic> data) async {
    try {
      var response = await _client.get("/tracks?", queryParameters: data);
      return (response.data as List)
          .map((item) => TeamModel.fromJson(item))
          .toList();
    } on DioError catch (e) {
      throw (e.message);
      // throw (e.responde.data); // if the API response a error.
    }
  }

  Future<TeamModel> createTrack(Map<String, dynamic> data) async {
    try {
      var response = await _client.post("/tracks", data: data);
      return TeamModel.fromJson(response.data);
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  Future<TeamModel> uploadPhoto(Map<String, dynamic> data) async {
    try {
      var response = await _client.post("/upload", data: data);
      return TeamModel.fromJson(response.data);
    } on DioError catch (e) {
      throw (e.message);
    }
  }
}
