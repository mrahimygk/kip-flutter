import 'dart:ui';

import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final Color itemColor;

  const ColorItem({Key key, this.itemColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: itemColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
