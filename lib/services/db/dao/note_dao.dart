import 'package:kip/models/note/note_model.dart';

import 'dao.dart';

class NoteDao implements Dao<NoteModel> {
  @override
  String get createTableQuery => 'create table $noteTable ('
      '$noteColumnId text primary key,'
      '$noteColumnTitle text, '
      '$noteColumnContent text, '
      '$noteColumnColor text, '
      '$noteColumnDrawingList text, '
      '$noteColumnVoiceList text, '
      '$noteColumnCheckboxList text, '
      '$noteColumnLabelList text, '
      '$noteColumnCreatedDate text, '
      '$noteColumnModifiedDate text, '
      '$noteColumnIsPinned BOOLEAN NOT NULL CHECK ($noteColumnIsPinned IN (0,1) '
      ')';

  @override
  Map<String, dynamic> toMap(NoteModel object) {
    return <String, dynamic>{
      noteColumnId: object.id,
      noteColumnTitle: object.title,
      noteColumnContent: object.content,
      noteColumnColor: object.color,
      noteColumnDrawingList: object.drawingList,
      noteColumnVoiceList: object.voiceList,
      noteColumnCheckboxList: object.checkboxList,
      noteColumnLabelList: object.labelList,
      noteColumnIsPinned: object.isPinned,
      noteColumnCreatedDate: object.createdDate,
      noteColumnModifiedDate: object.modifiedDate
    };
  }

  @override
  List<NoteModel> fromList(List<Map<String, dynamic>> query) {
    List<NoteModel> res = List<NoteModel>();
    for (Map map in query) {
      res.add(fromMap(map));
    }

    return res;
  }

  @override
  NoteModel fromMap(Map<String, dynamic> query) => NoteModel(
        query[noteColumnId],
        query[noteColumnTitle],
        query[noteColumnContent],
        query[noteColumnColor],
        query[noteColumnDrawingList],
        query[noteColumnVoiceList],
        query[noteColumnCheckboxList],
        query[noteColumnLabelList],
        query[noteColumnIsPinned],
        query[noteColumnCreatedDate],
        query[noteColumnModifiedDate],
      );
}

const noteTable = 'note';
const noteColumnId = 'id';
const noteColumnTitle = 'title';
const noteColumnContent = 'content';
const noteColumnColor = 'color';
const noteColumnDrawingList = 'drawing_list';
const noteColumnVoiceList = 'voice_list';
const noteColumnCheckboxList = 'checkbox_list';
const noteColumnLabelList = 'label_list';
const noteColumnIsPinned = 'is_linned';
const noteColumnCreatedDate = 'created_date';
const noteColumnModifiedDate = 'modified_date';
