import 'base_api.dart';

class UserApi {
  final BaseApi api = BaseApi();

  Future<dynamic> login(String path, Map<String, dynamic> params) async {
    return api.post(path, params);
  }

  Future<dynamic> register(String path, Map<String, dynamic> params) async {
    return api.post(path, params);
  }
}
