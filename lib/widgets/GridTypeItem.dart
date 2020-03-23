import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kip/pages/DrawingPage.dart';
import 'package:kip/widgets/PaintSurface.dart';

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
          item.isSelected
              ? Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Container(
                      height: itemSize,
                      width: itemSize,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 2.0)),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class GridWidgetPainter extends CustomPainter {
  final GridDrawer canvasDrawer = GridDrawer();
  final GridType gridType;

  GridWidgetPainter(this.gridType);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    canvasDrawer.drawGrids(canvas, size, gridType);
  }
}
