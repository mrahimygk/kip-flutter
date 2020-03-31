import 'package:kip/models/note/note_model.dart';
import 'package:kip/services/repo/base_repo.dart';

abstract class NoteRepo extends BaseRepo<NoteModel> {
  Future sync();
}
