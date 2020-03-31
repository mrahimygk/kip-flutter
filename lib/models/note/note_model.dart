import 'dart:ui';

import 'package:flutter/cupertino.dart';
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
        json['id'],
        json['title'],
        json['content'],
        HexColor.fromHex(json['color']),
        json['drawing_list'],
        json['voice_list'],
        json['checkbox_list'],
//        CheckboxModel.fromMap(json['checkbox_list']),
        json['label_list'],
        json['is_pinned']);
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['drawing_list'] = drawingList;
    data['voice_list'] = voiceList;
    data['checkbox_list'] = checkboxList;
    data['label_list'] = labelList;
    data['is_pinned'] = isPinned;
    data['content'] = color.toHex();
    return data;
  }
}
