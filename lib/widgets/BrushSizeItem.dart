import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kip/pages/DrawingPage.dart';

class BrushSizeItem extends StatelessWidget {
  final VoidCallback onPress;
  final BrushSizeModel item;

  BrushSizeItem({Key key, this.onPress, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Stack(
        children: <Widget>[
          ///grey bg
          Container(
            width: 48,
            height: 48,
          ),

          ///actual circle
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: item.size,
                width: item.size,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          item.isSelected
              ? Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all()),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
