import 'package:kip/models/note/note_model.dart';

class AddNotePageArguments {
  final bool shouldAddDrawing;
  final bool shouldAddCheckboxes;
  final NoteModel note;

  //TODO: + editing note
  AddNotePageArguments(this.shouldAddDrawing, this.shouldAddCheckboxes, this.note);
}
