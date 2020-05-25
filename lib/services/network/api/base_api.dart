import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kip/services/network/error/api_exception.dart';

class BaseApi {
  static final String _baseUrl = "http://192.168.1.159:8080";

  final dio = Dio()
    ..options.baseUrl = _baseUrl
    ..interceptors.add(LogInterceptor());

  Future<dynamic> get(String path, Map<String, dynamic> params) async {
    var responseJson;
    try {
      final response = await dio.get(path, queryParameters: params);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e, s) {
      if (e.error is SocketException)
        throw FetchDataException('Cannot reach server');
      handleDioError(e.response);
      reportStackTrace(s);
    }

    return responseJson;
  }

  Future<dynamic> post(String path, Map<String, dynamic> params) async {
    var responseJson;
    try {
      final response = await dio.post(path, data: FormData.fromMap(params));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e, s) {
      if (e.error is SocketException)
        throw FetchDataException('Cannot reach server');
      handleDioError(e.response);
      reportStackTrace(s);
    }

    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    if (response.statusCode == 200) {
      var responseJson = response.data;
      print(responseJson);
      return responseJson;
    } else
      handleDioError(response);
  }

  void handleDioError(Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode} (${response.statusMessage})');
    }
  }

  void reportStackTrace(StackTrace s) {}
}
