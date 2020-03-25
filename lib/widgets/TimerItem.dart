import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimerItem extends StatelessWidget {
  final Duration recordedDuration;
  final int millis;

  TimerItem(this.recordedDuration, this.millis);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
//        Text(recordedDuration.toString())
        Text(recordedDuration.inHours.toString().padLeft(2,'0')),
        Text(":"),
        Text((recordedDuration.inMinutes % 60).toString().padLeft(2,'0')),
        Text(":"),
        Text((recordedDuration.inSeconds % 60).toString().padLeft(2,'0')),
        Text("."),
        Text(millis.toString().padLeft(3,'0')),
      ],
    );
  }
}
