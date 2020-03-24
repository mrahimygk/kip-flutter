import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kip/widgets/KipBar.dart';
import 'package:kip/widgets/MenuItem.dart';
import 'package:kip/widgets/NoteItem.dart';
import 'package:path_provider/path_provider.dart';

class KipMainPage extends StatefulWidget {
  @override
  _KipMainPageState createState() => _KipMainPageState();
}

class _KipMainPageState extends State<KipMainPage> {
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
                  startVoiceRecording();
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
    //TODO: new note with picture
  }

  void openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    //TODO: new note with picture
  }

  bool isRecording = false;
  FlutterAudioRecorder recorder;
  Timer timer;

  void startVoiceRecording() async {
    if (isRecording) {
      var result = await recorder.stop();
      print(result.path);
      timer.cancel();
      //todo: dismiss dialog
    } else {
      bool hasPermission = await FlutterAudioRecorder.hasPermissions;
      print(hasPermission);
      if (!hasPermission) return;

      Directory tempDir = await getTemporaryDirectory();
      File outputFile =
          File('${tempDir.path}/${DateTime.now().millisecond}.aac');
      recorder = FlutterAudioRecorder(
        outputFile.path,
        audioFormat: AudioFormat.AAC,
      );
      await recorder.initialized;
      await recorder.start();
      isRecording = true;
      timer = Timer.periodic(Duration(milliseconds: 50), (Timer t) async {
        var current = await recorder.current(channel: 0);
        print(current.status);
        setState(() {
          //TODO: update ui
        });
      });
    }
  }
}
