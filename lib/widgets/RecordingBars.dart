import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class RecordingBars extends StatelessWidget {
  final Widget child;
  final double maxLineLength;
  final double audioPeak;
  final List<int> thresholds;

  const RecordingBars(
      {Key key,
      this.child,
      this.maxLineLength,
      this.audioPeak,
      this.thresholds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BarsPainter(maxLineLength, audioPeak, thresholds),
      child: child,
    );
  }
}

class BarsPainter extends CustomPainter {
  final Paint painter = Paint()
    ..color = Colors.blue
    ..strokeWidth = 2;

  final int pointCount = 66;
  final double maxLineLength;
  final double audioPeak;
  final List<int> thresholds;
  final points = List();

  BarsPainter(this.maxLineLength, this.audioPeak, this.thresholds) {
    final random = Random();

    for (int i = 1; i <= pointCount; i++) {
      points.add(audioPeak / (random.nextInt(thresholds[i - 1]) + 1));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), painter);
    final rad = size.height / 2.25; // - 18.0*2;
    for (int i = 0; i < 360; i = i + (360 / pointCount).floor()) {
      int index = (i * pointCount / 360).round();
      var peakValue = points[index];
      if (peakValue > maxLineLength) peakValue = maxLineLength;
      canvas.save();
      canvas.transform(
          Matrix4Transform().rotateByCenterDegrees(-90, size).m.storage);
      canvas.transform(Matrix4Transform()
          .rotateByCenterDegrees(-i.toDouble(), size)
          .m
          .storage);
      final cx = size.width / 2.0 + rad;
      final cy = size.height / 2.0;
      canvas.drawLine(Offset(cx, cy), Offset(cx + peakValue, cy), painter);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
