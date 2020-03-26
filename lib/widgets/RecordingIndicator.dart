import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RecordingBars.dart';

class RecordingIndicator extends StatelessWidget {
  final double audioPeak;
  final List<int> thresholds;

  RecordingIndicator(this.audioPeak, this.thresholds);

  @override
  Widget build(BuildContext context) {
    final padding = 18.0;
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(padding * (3 / 4)),
            child: RecordingBars(
              audioPeak: audioPeak,
              thresholds: thresholds,
              maxLineLength: padding,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Icon(
                  Icons.mic,
                  size: 42,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
