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
  ) {
    if (controller == null) controller = TextEditingController();
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
    );
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['text'] = text;
    data['indent'] = indent;
    data['checked'] = checked;
    return data;
  }

//  factory CheckboxModel.fromJson(Map<String, dynamic> json) => _$CheckboxModelFromJson(json);

  Map toJson() => {
        'id': id,
        'text': text,
        'indent': indent,
        'checked': checked,
        'hasFocus': hasFocus,
      };

  void dispose() {
    controller.dispose();
  }
}
