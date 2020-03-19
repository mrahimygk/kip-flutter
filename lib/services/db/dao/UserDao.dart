import 'package:kip/models/User.dart';

import 'Dao.dart';

class UserDao implements Dao<User> {
  @override
  String get createTableQuery => 'create table $userTable ('
      '$userColumnEmail text primary key,'
      '$userColumnAvatar text '
      ')';

  @override
  Map<String, dynamic> toMap(User object) {
    return <String, dynamic>{
      userColumnEmail: object.email,
      userColumnAvatar: object.avatar
    };
  }

  @override
  List<User> fromList(List<Map<String, dynamic>> query) {
    List<User> users = List<User>();
    for (Map map in query) {
      users.add(fromMap(map));
    }

    return users;
  }

  @override
  User fromMap(Map<String, dynamic> query) =>
      User(query[userColumnEmail], query[userColumnAvatar]);
}

const userTable = 'user';
const userColumnEmail = 'email';
const userColumnPass = 'pass';
const userColumnAvatar = 'avatar';
