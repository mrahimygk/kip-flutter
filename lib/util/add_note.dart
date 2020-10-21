import 'package:flutter/material.dart';
import 'package:kip/models/add_note_page_arguments.dart';

class AddNote {
  static addNote(BuildContext context, AddNotePageArguments arguments) async {
    final shouldDiscard =
        await Navigator.of(context).pushNamed('/addNote', arguments: arguments);
    if (shouldDiscard) {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Empty Note Discarded"),
      ));
    }
  }
}
