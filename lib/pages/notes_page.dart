import 'package:flutter/material.dart';
import 'package:kip/blocs/note_bloc.dart';
import 'package:kip/models/add_note_page_arguments.dart';
import 'package:kip/models/note/note_model.dart';
import 'package:kip/util/add_note.dart';
import 'package:kip/widgets/bordered_container.dart';
import 'package:kip/widgets/note_item.dart';

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NoteModel>>(
      stream: noteBloc.notes,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return buildNoteList(snapshot, context);
        else if (snapshot.hasError)
          return Center(child: Text(snapshot.error.toString()));
        else if (snapshot.data == null || snapshot.data.length == 0) {
          return Center(child: Text("ADD NOTES TO SEE THEM HERE"));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildNoteList(
      AsyncSnapshot<List<NoteModel>> snapshot, BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        final note = snapshot.data[index];
        return NoteItem(
          color: note.color,
          child: Dismissible(
            background: BorderedContainer(color: Colors.red),
            onDismissed: (dir) {
              noteBloc.deleteNote(note);
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Note removed"),
                  action: SnackBarAction(
                      textColor: Colors.orange,
                      label: "UNDO",
                      onPressed: () {
                        noteBloc.insertNote(note);
                      })));
            },
            key: ObjectKey(note.id),
            child: ListTile(
              leading: Text(note.title),
              title: Text(note.content),
              onTap: () {
                AddNote.addNote(context,
                    AddNotePageArguments(false, false, "", null, note));
              },
            ),
          ),
        );
      },
    );
  }
}
