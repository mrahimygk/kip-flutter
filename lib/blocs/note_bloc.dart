import 'dart:async';

import 'package:kip/models/note/note_model.dart';
import 'package:kip/services/db/database_provider.dart';
import 'package:kip/services/repo/note_repo_impl.dart';

class NoteBloc {
  final noteRepo = NoteRepoImpl(DatabaseProvider.get);
  final noteController = StreamController<List<NoteModel>>.broadcast();

  get notes => noteController.stream;

  NoteBloc() {
    getNotes();
  }

  getNotes() async {
    noteController.add(await noteRepo.getAllFromDb());
  }

  insertNote(NoteModel noteModel) async {
    await noteRepo.insert(noteModel);
    getNotes();
  }

  updateNote(NoteModel noteModel) async {
    await noteRepo.update(noteModel);
    getNotes();
  }

  deleteNote(NoteModel noteModel) async {
    await noteRepo.delete(noteModel);
    getNotes();
  }

  dispose() {
    noteController.close();
  }
}

final noteBloc = NoteBloc();