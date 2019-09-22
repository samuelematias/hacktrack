import 'package:dio/dio.dart';

import '../../shared/custom_dio/custom_dio.dart';
import '../../shared/models/join_model.dart';

class JoinRepository {
  final CustomDio _client;

  JoinRepository(this._client);

  Future<JoinModel> validateCode(Map<String, dynamic> data) async {
    try {
      var response =
          await _client.get("/hackathons/validate??", queryParameters: data);
      return JoinModel.fromJson(response.data);
    } on DioError catch (e) {
      throw (e.message);
      // throw (e.responde.data); // if the API response a error.
    }
  }
}
