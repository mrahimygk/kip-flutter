import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kip/services/network/error/ApiException.dart';

class BaseApi {
  final String _baseUrl = "http://192.168.1.159:8080";

  final dio = Dio();

  Future<dynamic> get(String path, Map<String, dynamic> params) async {
    var responseJson;
    try {
      final response = await dio.get(_baseUrl + path, queryParameters: params);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> post(String path, Map<String, dynamic> params) async {
    var responseJson;
    try {
      final response =
          await dio.post(_baseUrl + path, data: FormData.from(params));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
