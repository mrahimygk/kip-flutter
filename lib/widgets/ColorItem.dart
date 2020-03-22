import 'dart:ui';

import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final Color itemColor;
  final double size;
  final VoidCallback onPress;

  ColorItem({Key key, this.itemColor, this.onPress, this.size = 24.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        onPress();
      } ,
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
                  color: itemColor,
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
