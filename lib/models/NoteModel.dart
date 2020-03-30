import 'dart:ui';

import 'package:flutter/cupertino.dart';

class NoteModel {
  final String id;
  String title;
  Color color;
  final List<String> drawingList;
  final List<String> voiceList;
  final List<CheckboxModel> checkboxList;
  final List<String> labelList;
  bool isPinned;

  NoteModel(this.id, this.title, this.color, this.drawingList, this.voiceList,
      this.checkboxList, this.labelList, this.isPinned);
}

class CheckboxModel {
  final String id;
  String text;
  int indent;
  bool checked;
  bool hasFocus;
  final TextEditingController controller;

  CheckboxModel(
    this.id,
    this.text,
    this.indent,
    this.checked,
    this.hasFocus,
    this.controller,
  ){
    controller.text = text;
    controller.addListener((){
      text = controller.text;
    });
  }
}
