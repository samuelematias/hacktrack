import 'package:dio/dio.dart';

import '../../shared/custom_dio/custom_dio.dart';
import '../../shared/models/hackathon_model.dart';

class CreateRepository {
  final CustomDio _client;

  CreateRepository(this._client);

  Future<HackathonModel> createHackathon(Map<String, dynamic> data) async {
    try {
      var response = await _client.post("/hackathons", data: data);
      return HackathonModel.fromJson(response.data);
    } on DioError catch (e) {
      throw (e.message);
    }
  }
}
