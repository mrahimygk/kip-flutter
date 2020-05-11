import 'package:kip/services/db/database_provider.dart';

abstract class BaseRepo<T> {
  DatabaseProvider databaseProvider;

  Future insert(T data);

  Future update(T data);

  Future delete(T data);

  Future<T> getFromDb();

  Future<List<T>> getAllFromDb();
}
