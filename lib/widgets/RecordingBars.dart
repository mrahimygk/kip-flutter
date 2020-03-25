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
  final Paint painter = Paint()..color = Colors.blue;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
