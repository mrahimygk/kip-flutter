import 'package:kip/models/note/note_model.dart';

import 'note/voice_model.dart';

class AddNotePageArguments {
  final bool shouldAddDrawing;
  final bool shouldAddCheckboxes;
  final String imagePath;
  final VoiceModel voice;
  final NoteModel note;

  //TODO: + editing note
  AddNotePageArguments(
    this.shouldAddDrawing,
    this.shouldAddCheckboxes,
    this.imagePath,
    this.voice,
    this.note,
  );
}
