import 'package:dio/dio.dart';

import '../constants.dart';
import 'interceptors.dart';

class CustomDio extends Dio {
  CustomDio() {
    options.baseUrl = BASE_URL;
    interceptors.add(CustomIntercetors());
    options.connectTimeout = 15000; //15s
  }
}
