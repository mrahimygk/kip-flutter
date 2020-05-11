import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'checkbox_model.dart';

class NoteModel {
  final String id;
  String title;
  String content;
  Color color;
  final List<String> drawingList;
  final List<String> voiceList;
  final List<CheckboxModel> checkboxList;
  final List<String> labelList;
  bool isPinned;
  final String createdDate;
  String modifiedDate;

  NoteModel(
    this.id,
    this.title,
    this.content,
    this.color,
    this.drawingList,
    this.voiceList,
    this.checkboxList,
    this.labelList,
    this.isPinned,
    this.createdDate,
    this.modifiedDate,
  );
}
