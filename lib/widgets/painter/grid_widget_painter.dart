
import 'package:flutter/cupertino.dart';

import '../paint_surface.dart';

class GridWidgetPainter extends CustomPainter {
  GridDrawer canvasDrawer;
  final GridType gridType;
  final int space;

  GridWidgetPainter(this.gridType, this.space){
    canvasDrawer = GridDrawer(space);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    canvasDrawer.drawGrids(canvas, size, gridType);
  }
}