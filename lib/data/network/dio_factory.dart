// ignore_for_file: constant_identifier_names, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_advanced/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANG = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANG: "en",
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout: Constants.appTimeOut,
      sendTimeout: Constants.appTimeOut,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          responseHeader: true,
          requestBody: true,
        ),
      );
    }
    return dio;
  }
}
