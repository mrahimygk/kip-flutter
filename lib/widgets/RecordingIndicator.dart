import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RecordingBars.dart';

class RecordingIndicator extends StatelessWidget {
  RecordingIndicator(double audioPeak);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: RecordingBars(),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.mic,
              size: 64,
            ),
          ),
        ),
      ],
    );
  }
}
