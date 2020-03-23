
import 'package:flutter/cupertino.dart';

import '../PaintSurface.dart';

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