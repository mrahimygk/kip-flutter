import 'package:kip/models/user.dart';
import 'package:kip/services/db/database_provider.dart';
import 'package:kip/services/db/dao/user_dao.dart';
import 'package:kip/services/network/api/api_result.dart';
import 'package:kip/services/network/api/user_api.dart';
import 'package:kip/services/network/data/api_response.dart';
import 'package:kip/services/repo/user_repo.dart';
import 'package:sqflite/sqflite.dart';

class UserRepoImpl implements UserRepo {
  final dao = UserDao();
  final UserApi api = UserApi();

  @override
  DatabaseProvider databaseProvider;

  UserRepoImpl(this.databaseProvider);

  @override
  Future insert(User data) async {
    final db = await databaseProvider.db();
    await db.insert(userTable, dao.toMap(data),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future update(User data) async {
    final db = await databaseProvider.db();
    await db.update(userTable, dao.toMap(data),
        where: '$userColumnEmail = ?', whereArgs: [data.email]);
  }

  @override
  Future delete(User data) async {
    final db = await databaseProvider.db();
    await db.delete(userTable,
        where: '$userColumnEmail = ?', whereArgs: [data.email]);
  }

  @override
  Future<User> getFromDb() async {
    final db = await databaseProvider.db();
    List<Map> map = await db.query(
      userTable,
      columns: [
        userColumnEmail,
        userColumnAvatar,
      ],
    );
    if (map.length > 0) {
      return dao.fromList(map).first;
    }
    return null;
  }

  @override
  Future<ApiResult<User>> login(String email, String pass) async {
    final data = Map<String, String>();
    data[userColumnEmail] = email;
    data[userColumnPass] = pass;
    final response = await api.login(LOGIN_URL, data);
    final result = ApiResponse.fromMap(response);
    if (result.data == null) return ApiResult.error(result.statusText);
    final user = User.fromMap(result.data);
    return ApiResult.completed(user) ?? null;
  }

  @override
  Future<ApiResult<User>> register(String email, String pass) async {
    final data = Map<String, String>();
    data[userColumnEmail] = email;
    data[userColumnPass] = pass;
    final response = await api.register(REGISTER_URL, data);
    final result = ApiResponse.fromMap(response);
    if (result.data == null) return ApiResult.error(result.statusText);
    final user = User.fromMap(result.data);
    return ApiResult.completed(user) ?? null;
  }
}

const LOGIN_URL = "/login";
const REGISTER_URL = "/register";
