import 'dart:ui';

import 'package:flutter/material.dart';

class BrushSizeItem extends StatelessWidget {
  final double size;
  final VoidCallback onPress;

  BrushSizeItem({Key key, this.onPress, this.size})
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
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
