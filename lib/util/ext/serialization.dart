import 'package:kip/models/note/checkbox_model.dart';

extension DynamicListConverter on List<dynamic> {
  mapToStringList() => this.map((e) {
        return e.toString();
      }).toList();

  mapToCheckBoxList() => this.map((e) {
        return CheckboxModel.fromMap(e);
      }).toList();
}
