import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kip/blocs/note_bloc.dart';
import 'package:kip/models/add_note_page_arguments.dart';
import 'package:kip/models/note/note_model.dart';
import 'package:kip/util/ready_mades.dart';
import 'package:kip/widgets/bar.dart';
import 'package:kip/widgets/bordered_container.dart';
import 'package:kip/widgets/menu_item.dart';
import 'package:kip/widgets/note_item.dart';
import 'package:kip/widgets/recording_indicator.dart';
import 'package:kip/widgets/timer_item.dart';
import 'package:path_provider/path_provider.dart';

class KipMainPage extends StatefulWidget {
  @override
  _KipMainPageState createState() => _KipMainPageState();
}

class _KipMainPageState extends State<KipMainPage> {
  final List<int> thresholds = ReadyMade.makeThresholds(66);

  @override
  void dispose() {
    noteBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.check_box),
                onPressed: () {
                  addNote(context, AddNotePageArguments(false, true, null));
                },
              ),
              IconButton(
                icon: Icon(Icons.brush),
                onPressed: () {
                  addNote(context, AddNotePageArguments(true, false, null));
                },
              ),
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: () {
                  startVoiceRecording(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.photo),
                onPressed: () {
                  showPictureChoiceDialog(context);
                },
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            KipBar(onRequestLogin: () {
              onNavigateToLogin(context);
            }),
            Expanded(
              child: StreamBuilder<List<NoteModel>>(
                stream: noteBloc.notes,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return buildNoteList(snapshot, context);
                  else if (snapshot.hasError)
                    return Center(child: Text(snapshot.error.toString()));
                  else if (snapshot.data == null || snapshot.data.length == 0) {
                    return Center(child: Text("ADD NOTES TO SEE THEM HERE"));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addNote(context, AddNotePageArguments(false, false, null));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  addNote(BuildContext context, AddNotePageArguments arguments) {
    Navigator.of(context).pushNamed('/addNote', arguments: arguments);
  }

  onNavigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/login');
  }

  void showPictureChoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Image"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MenuItem(
              color: Colors.white,
              onPress: () {
                Navigator.of(context).pop();
                openCamera();
              },
              icon: Icons.photo_camera,
              text: "Take photo",
            ),
            MenuItem(
              color: Colors.white,
              onPress: () {
                Navigator.of(context).pop();
                openGallery();
              },
              icon: Icons.image,
              text: "Coose image",
            )
          ],
        ),
      ),
    );
  }

  void openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    //TODO: NEW_NOTE with picture
  }

  void openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    //TODO: NEW_NOTE with picture
  }

  bool isRecording = false;
  FlutterAudioRecorder recorder;
  Timer timer;
  double audioPeak = 0.0;

  void startVoiceRecording(BuildContext context) async {
    if (isRecording) {
      var result = await endRecording();
      //TODO: NEW_NOTE with recording
      print(result.path);
    } else {
      bool hasPermission = await FlutterAudioRecorder.hasPermissions;
      print(hasPermission);
      if (!hasPermission) return;

      Directory tempDir = await getTemporaryDirectory();
      File outputFile =
          File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.aac');
      recorder = FlutterAudioRecorder(
        outputFile.path,
        audioFormat: AudioFormat.AAC,
      );
      await recorder.initialized;
      await recorder.start();
      isRecording = true;
      showDialog(
        context: context,
        builder: (context) => makeStatefulDialog(),
      );
    }
  }

  Future<Recording> endRecording() async {
    isRecording = false;
    var result = await recorder.stop();
    timer.cancel();
    return result;
  }

  Widget makeStatefulDialog() {
    Duration recordedDuration = Duration.zero;
    int millis = 0;
    return StatefulBuilder(builder: (context, setState) {
      final period = 50;
      timer = Timer.periodic(Duration(milliseconds: 50), (Timer t) async {
        var current = await recorder.current(channel: 0);
        if (mounted && isRecording)
          setState(() {
            millis += period;
            if (millis > 999) millis = 0;
            recordedDuration = current.duration;
            audioPeak = current.metering.peakPower + 120;
          });
        if (!isRecording) timer.cancel();
      });

      return AlertDialog(
        title: Text("Add Recording"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 12.0,
              ),
              RecordingIndicator(audioPeak, thresholds),
              TimerItem(recordedDuration, millis),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              ///unused recording discarded/ignored
              endRecording();
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Save"),
            onPressed: () {
              startVoiceRecording(context);
            },
          )
        ],
      );
    });
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
                  content: Text("Item deleted"),
                  action: SnackBarAction(
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
                addNote(context, AddNotePageArguments(false, false, note));
              },
            ),
          ),
        );
      },
    );
  }
}
