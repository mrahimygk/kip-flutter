import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kip/blocs/note_bloc.dart';
import 'package:kip/models/add_note_page_arguments.dart';
import 'package:kip/models/note/voice_model.dart';
import 'package:kip/pages/archived_page.dart';
import 'package:kip/pages/deleted_page.dart';
import 'package:kip/pages/notes_page.dart';
import 'package:kip/pages/reminder_page.dart';
import 'package:kip/util/add_note.dart';
import 'package:kip/util/ready_mades.dart';
import 'package:kip/widgets/app_drawer.dart';
import 'package:kip/widgets/bar.dart';
import 'package:kip/widgets/menu_item.dart';
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

  //List of pages to be shown in main body;
  List<Widget> _pages = [
    NotesPage(),
    RemindersPage(),
    ArchivedPages(),
    DeletedPage(),
  ];

  int _currentPageIndex = 0;
  //Global Key to handle scaffold's drawer
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: AppDrawer(
          //Passing Function to change main body
          callback: changeCurrentIndexPage,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Builder(builder: (context) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.check_box),
                  onPressed: () {
                    AddNote.addNote(context,
                        AddNotePageArguments(false, true, "", null, null));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.brush),
                  onPressed: () {
                    AddNote.addNote(context,
                        AddNotePageArguments(true, false, "", null, null));
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
            );
          }),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            KipBar(
              onRequestLogin: () {
                onNavigateToLogin(context);
              },
              gKey: _key,
            ),
            Expanded(
              child: _pages[_currentPageIndex],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              AddNote.addNote(
                  context, AddNotePageArguments(false, false, "", null, null));
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }

  onNavigateToLogin(BuildContext context) {
    Scaffold.of(context).removeCurrentSnackBar();
    Navigator.of(context).pushNamed('/login');
  }

  //Function to change the index of curren Page;
  void changeCurrentIndexPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
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
              text: "Choose image",
            )
          ],
        ),
      ),
    );
  }

  void openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    AddNote.addNote(
        context, AddNotePageArguments(false, false, picture.path, null, null));
  }

  void openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    AddNote.addNote(
        context, AddNotePageArguments(false, false, picture.path, null, null));
  }

  bool isRecording = false;
  FlutterAudioRecorder recorder;
  Timer timer;
  double audioPeak = 0.0;

  void startVoiceRecording(BuildContext context) async {
    if (isRecording) {
      var result = await endRecording();
      Navigator.of(context).pop();
      AddNote.addNote(
        context,
        AddNotePageArguments(false, false, "",
            VoiceModel(result.path.split("/").last, result.path), null),
      );
    } else {
      bool hasPermission = await FlutterAudioRecorder.hasPermissions;
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
}
