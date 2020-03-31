import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:kip/services/db/dao/note_dao.dart';
import 'package:kip/util/ext/color.dart';

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
  );

  factory NoteModel.fromMap(Map<String, dynamic> json) {
//    final checkboxList = List<CheckboxModel>();

    return NoteModel(
        json[noteColumnId],
        json[noteColumnTitle],
        json[noteColumnContent],
        HexColor.fromHex(json[noteColumnColor]),
        json[noteColumnDrawingList],
        json[noteColumnVoiceList],
        json[noteColumnCheckboxList],
//        CheckboxModel.fromMap(json['checkbox_list']),
        json[noteColumnLabelList],
        json[noteColumnIsPinned]);
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data[noteColumnId] = id;
    data[noteColumnTitle] = title;
    data[noteColumnContent] = content;
    data[noteColumnColor] = color.toHex();
    data[noteColumnDrawingList] = drawingList;
    data[noteColumnVoiceList] = voiceList;
    data[noteColumnCheckboxList] = checkboxList;
    data[noteColumnLabelList] = labelList;
    data[noteColumnIsPinned] = isPinned;
    return data;
  }
}
