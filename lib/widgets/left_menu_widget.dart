import 'package:flutter/material.dart';
import 'package:kip/models/note/note_model.dart';
import 'package:kip/util/make_shadow_colo.dart';
import 'package:kip/widgets/menu_item.dart';
import 'package:kip/widgets/menu_shadows.dart';

class LeftMenuWidget extends StatelessWidget {
  final Animation<Offset> leftMenuOffsetAnim;
  final NoteModel note;
  final Function addCheckBox;
  final Function toggleShowLeftMenu;
  const LeftMenuWidget({
    Key key,
    @required this.leftMenuOffsetAnim,
    @required this.note,
    @required this.addCheckBox,
    @required this.toggleShowLeftMenu,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: leftMenuOffsetAnim,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 48.0),
        child: Container(
          decoration: BoxDecoration(
            color: note.color,
            boxShadow: MenuShadows().get(
              MakeShaodowColor.makeShadow(note.color),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(height: 8),
              MenuItem(
                color: note.color,
                onPress: () {},
                icon: Icons.photo_camera,
                text: "Take photo",
              ),
              MenuItem(
                color: note.color,
                onPress: () {},
                icon: Icons.image,
                text: "Choose image",
              ),
              MenuItem(
                color: note.color,
                onPress: () {
                  toggleShowLeftMenu();
                  Navigator.of(context).pushNamed("/addDrawing");
                },
                icon: Icons.brush,
                text: "Drawing",
              ),
              MenuItem(
                color: note.color,
                onPress: () {},
                icon: Icons.mic,
                text: "Recording",
              ),
              note.checkboxList.length > 0
                  ? Container(height: 8)
                  : MenuItem(
                      color: note.color,
                      onPress: () {
                        toggleShowLeftMenu();
                        addCheckBox();
                      },
                      icon: Icons.check_box,
                      text: "Checboxes",
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
