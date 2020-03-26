import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kip/util/ReadyMades.dart';
import 'package:kip/widgets/KipBar.dart';
import 'package:kip/widgets/MenuItem.dart';
import 'package:kip/widgets/NoteItem.dart';
import 'package:kip/widgets/RecordingIndicator.dart';
import 'package:kip/widgets/TimerItem.dart';
import 'package:path_provider/path_provider.dart';

class KipMainPage extends StatefulWidget {
  @override
  _KipMainPageState createState() => _KipMainPageState();
}

class _KipMainPageState extends State<KipMainPage> {
  final List<int> thresholds = ReadyMade.makeThresholds(66);

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
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.brush),
                onPressed: () {},
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
              child: ListView(
                children: <Widget>[
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addNote(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  addNote(BuildContext context) {
    Navigator.of(context).pushNamed('/addNote');
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
      timer = Timer.periodic(Duration(milliseconds: 50), (Timer t) async {
        var current = await recorder.current(channel: 0);
        if (mounted && isRecording)
          setState(() {
            millis += 50;
            if (millis > 999) millis = 0;
            recordedDuration = current.duration;
            audioPeak = current.metering.peakPower;
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
