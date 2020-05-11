import 'base_api.dart';

class NoteApi {
  final BaseApi api = BaseApi();

  Future<dynamic> fetchAll(Map<String, dynamic> params) async {
    return api.get(NOTES_URL, params);
  }

  Future<dynamic> fetch(String id, Map<String, dynamic> params) async {
    return api.get("$NOTES_URL/$id", params);
  }

  Future<dynamic> put(Map<String, dynamic> params) async {
    return api.post(NOTES_URL, params);
  }
}

const NOTES_URL = "/note";