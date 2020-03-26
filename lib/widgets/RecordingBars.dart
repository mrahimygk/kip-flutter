import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordingBars extends StatelessWidget {
  final Widget child;

  const RecordingBars({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BarsPainter(),
      child: child,
    );
  }
}

class BarsPainter extends CustomPainter {
  final Paint painter = Paint()
    ..color = Colors.blue
    ..strokeWidth = 4;

  final int pointCount = 66;

  @override
  void paint(Canvas canvas, Size size) {
    final rad = size.height / 8.0;
    for (int i = 0; i < 360; i = i + (360 / pointCount).floor()) {
      canvas.save();
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(-90);
      canvas.rotate(-i.toDouble());
      final cx = size.width / 2 + rad;
      final cy = size.height / 2;
      canvas.drawLine(Offset(cx, cy), Offset(cx + 10, cy), painter);
      canvas.restore();
    }
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
