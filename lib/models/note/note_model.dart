
import 'package:flutter/cupertino.dart';

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
