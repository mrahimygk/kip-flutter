import 'dart:ui';

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
  final String text;
  final int indent;
  bool checked;

  CheckboxModel(this.id, this.text, this.indent, this.checked);
}
