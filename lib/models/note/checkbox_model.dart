import 'package:flutter/cupertino.dart';

class CheckboxModel {
  final String id;
  String text;
  int indent;
  bool checked;
  bool hasFocus;
  TextEditingController controller;

  CheckboxModel(
    this.id,
    this.text,
    this.indent,
    this.checked,
    this.hasFocus,
    this.controller,
  ) {
    if (controller == null) return;
    controller.text = text;
    controller.addListener(() {
      text = controller.text;
    });
  }

  factory CheckboxModel.fromMap(Map<String, dynamic> json) {
    return CheckboxModel(
      json['id'],
      json['text'],
      json['indent'],
      json['checked'],
      json['hasFocus'],
      null,
    );
  }
}
