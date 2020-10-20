import 'package:flutter/material.dart';
import 'package:kip/models/note/note_model.dart';
import 'package:kip/pages/add_note_page.dart';
import 'package:kip/util/make_shadow_colo.dart';
import 'package:kip/widgets/menu_item.dart';
import 'package:kip/widgets/menu_shadows.dart';
import 'package:kip/widgets/note_color_item.dart';

class RightMenuWidget extends StatelessWidget {
  final Animation<Offset> rightMenuOffsetAnim;
  final NoteModel note;
  final Function toggleShowLeftMenu;
  final Function(int) onTap;
  final List<NoteColorModel> noteColors;

  const RightMenuWidget({
    Key key,
    this.rightMenuOffsetAnim,
    this.note,
    this.toggleShowLeftMenu,
    this.noteColors,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SlideTransition(
        position: rightMenuOffsetAnim,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 48.0),
          child: Container(
            decoration: BoxDecoration(
              color: note.color,
              boxShadow:
                  MenuShadows().get(MakeShaodowColor.makeShadow(note.color)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(height: 8),
                MenuItem(
                  color: note.color,
                  onPress: () {},
                  icon: Icons.delete,
                  text: "Delete",
                ),
                MenuItem(
                  color: note.color,
                  onPress: () {},
                  icon: Icons.content_copy,
                  text: "Make a copy",
                ),
                MenuItem(
                  color: note.color,
                  onPress: () {
                    toggleShowLeftMenu();
                    Navigator.of(context).pushNamed("/addDrawing");
                  },
                  icon: Icons.share,
                  text: "Send",
                ),
                MenuItem(
                  color: note.color,
                  onPress: () {},
                  icon: Icons.label_outline,
                  text: "Labels",
                ),
                Container(
                  height: 48,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: noteColors.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NoteColorItem(
                        onPress: () => onTap(index),
                        item: noteColors[index],
                        index: index,
                      );
                    },
                  ),
                ),
                Container(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
