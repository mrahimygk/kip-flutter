import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kip/pages/DrawingPage.dart';
import 'package:kip/widgets/PaintSurface.dart';
import 'package:kip/widgets/painter/GridWidgetPainter.dart';

class GridTypeItem extends StatelessWidget {
  final VoidCallback onPress;
  final GridTypeModel item;

  GridTypeItem({Key key, this.onPress, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemSize = 64.0;
    const padding = 18.0;

    return InkWell(
      onTap: () {
        onPress();
      },
      child: Stack(
        children: <Widget>[
          ///actual circle
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(padding),
              child: Container(
                height: itemSize,
                width: itemSize,
                child: ClipOval(
                  child: CustomPaint(
                    painter: GridWidgetPainter(item.gridType),
                  ),
                ),

                ///outer border
                decoration:
                    BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              ),
            ),
          ),

          ///selected indicator
          if (item.isSelected)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(padding),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        height: itemSize,
                        width: itemSize,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 2.0)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.check_circle, color: Colors.blue,),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
