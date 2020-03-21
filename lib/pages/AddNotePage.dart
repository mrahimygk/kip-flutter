import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  var _scaffoldKey = GlobalKey(debugLabel: "parentScaffold");

  @override
  Widget build(BuildContext context) {
    //TODO: get predefined data here: flag for added default checkboxes...
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
