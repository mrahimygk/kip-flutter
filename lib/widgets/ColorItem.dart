import 'dart:ui';

import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  final Color itemColor;
  double size;

  ColorItem({Key key, this.itemColor, this.size = 24.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: itemColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
