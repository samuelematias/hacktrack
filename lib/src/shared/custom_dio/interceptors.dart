import 'package:dio/dio.dart';

class CustomIntercetors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    // print("REQUEST[${options.method}] => PATH: ${options.path}");
    print(
        ' Request Path : [${options.method}] ${options.baseUrl}${options.path}');
    print(' Request Data : ${options.data.toString()}');
    print(' Request Headers : ${options.headers.toString()}');
    print(' Request QueryParameters : ${options.queryParameters.toString()}');
    return options;
  }

  @override
  onResponse(Response response) {
    //200
    //201
    // print("RESPONSE[${response.statusCode}] => PATH: ${response.request.path}");
    print(
        ' Response Path : [${response.request.method}] ${response.request.baseUrl}${response.request.path} Request Data : ${response.request.data.toString()}');
    print(' Response statusCode : ${response.statusCode}');
    print(' Response data : ${response.data.toString()}');
    return response;
  }

  @override
  onError(DioError error) {
    //Exception
    print("ERROR[${error.response.statusCode}] => PATH: ${error.request.path}");
    // if (e.response.statusCode == 404) return DioError(message: "Erro interno");
    print(
        ' Error Path : [${error.response.request.method}] ${error.response.request.baseUrl}${error.response.request.path} Request Data : ${error.response.request.data.toString()}');
    print(' Error statusCode : ${error.response.statusCode}');
    print(
        ' Error data : ${null != error.response.data ? error.response.data.toString() : ''}');

    return error;
  }
}
