import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kip/pages/AddNotePage.dart';

class NoteColorItem extends StatelessWidget {
  final VoidCallback onPress;
  final NoteColorModel item;
  final int index;

  const NoteColorItem({Key key, this.onPress, this.item, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTapUp: (d) {
          onPress();
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(width: index == 0 ? 0.5 : 0.1),
                shape: BoxShape.circle,
                color: item.showingColor,
              ),
            ),
            Positioned.fill(
              child: Align(
                child: item.isSelected ? Icon(Icons.check) : Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
