import 'package:dio/dio.dart';

class CustomIntercetors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    print("REQUEST[${options.method}] => PATH: ${options.path}");
    return options;
  }

  @override
  onResponse(Response response) {
    //200
    //201
    print("RESPONSE[${response.statusCode}] => PATH: ${response.request.path}");
    return response;
  }

  @override
  onError(DioError e) {
    //Exception
    print("ERROR[${e.response.statusCode}] => PATH: ${e.request.path}");
    // if (e.response.statusCode == 404) return DioError(message: "Erro interno");

    return e;
  }
}
