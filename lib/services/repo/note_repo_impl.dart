import 'package:kip/models/note/note_model.dart';
import 'package:kip/services/db/dao/note_dao.dart';
import 'package:kip/services/db/database_provider.dart';
import 'package:kip/services/network/api/note_api.dart';
import 'package:kip/services/repo/note_repo.dart';
import 'package:sqflite/sqflite.dart';

class NoteRepoImpl extends NoteRepo {
  final dao = NoteDao();
  final NoteApi api = NoteApi();

  @override
  DatabaseProvider databaseProvider;

  NoteRepoImpl(this.databaseProvider);

  @override
  Future delete(NoteModel data) async {
    final db = await databaseProvider.db();
    await db.delete(
      noteTable,
      where: '$noteColumnId = ?',
      whereArgs: [data.id],
    );
  }

  @override
  Future<NoteModel> getFromDb() {}

  @override
  Future<List<NoteModel>> getAllFromDb() async {
    final db = await databaseProvider.db();
    List<Map> map = await db.query(
      noteTable,
      columns: [
        noteColumnId,
        noteColumnTitle,
        noteColumnContent,
        noteColumnColor,
        noteColumnDrawingList,
        noteColumnVoiceList,
        noteColumnCheckboxList,
        noteColumnLabelList,
        noteColumnIsPinned,
        noteColumnCreatedDate,
        noteColumnModifiedDate,
      ],
    );

    if (map.length > 0) {
      return dao.fromList(map);
    }

    return null;
  }

  @override
  Future update(NoteModel data) async {
    final db = await databaseProvider.db();
    await db.update(
      noteTable,
      dao.toMap(data),
      where: '$noteColumnId = ?',
      whereArgs: [data.id],
    );
  }

  @override
  Future insert(NoteModel data) async {
    final db = await databaseProvider.db();
    db.insert(
      noteTable,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future sync() {
    ///TODO: fetch data, check for ids,
    ///TODO: compare by modified date
    ///TODO: update modified in db,
    ///TODO: check for absent notes in api reslut,
    ///TODO: post absent notes to api.
  }
}
