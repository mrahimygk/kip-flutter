import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kip/pages/DrawingPage.dart';

class ColorItem extends StatelessWidget {
  final BrushColorModel item;
  final VoidCallback onPress;

  ColorItem({
    Key key,
    this.item,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deselectedSize = 24.0;
    final selectedSize = 36.0;
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
                height: item.isSelected ? selectedSize : deselectedSize,
                width: item.isSelected ? selectedSize : deselectedSize,
                decoration: BoxDecoration(
                  color: item.color,
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
