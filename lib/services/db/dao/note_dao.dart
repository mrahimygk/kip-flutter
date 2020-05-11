import 'dart:convert';

import 'package:kip/models/note/note_model.dart';
import 'package:kip/util/ext/color.dart';
import 'package:kip/util/ext/serialization.dart';

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
      '$noteColumnIsPinned text'
      ')';

  @override
  Map<String, dynamic> toMap(NoteModel object) {
    return <String, dynamic>{
      noteColumnId: object.id,
      noteColumnTitle: object.title,
      noteColumnContent: object.content,
      noteColumnColor: object.color.toHex(),
      noteColumnDrawingList: jsonEncode(object.drawingList),
      noteColumnVoiceList: jsonEncode(object.voiceList),
      noteColumnCheckboxList: jsonEncode(object.checkboxList),
      noteColumnLabelList: jsonEncode(object.labelList),
      noteColumnIsPinned: object.isPinned ? "0" : "1",
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
        HexColor.fromHex(query[noteColumnColor]),
        (jsonDecode(query[noteColumnDrawingList].toString()) as List<dynamic>)
            .mapToStringList(),
        (jsonDecode(query[noteColumnVoiceList].toString()) as List<dynamic>)
            .mapToStringList(),
        (jsonDecode(query[noteColumnCheckboxList].toString()) as List<dynamic>)
            .mapToCheckBoxList(),
        (jsonDecode(query[noteColumnLabelList].toString()) as List<dynamic>)
            .mapToStringList(),
        query[noteColumnIsPinned].toString() == '0' ? false : true,
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
const noteColumnIsPinned = 'is_pinned';
const noteColumnCreatedDate = 'created_date';
const noteColumnModifiedDate = 'modified_date';
const noteColumnListItemSeparator = '|||';
