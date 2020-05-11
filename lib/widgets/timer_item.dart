import 'package:flutter/cupertino.dart';

class TimerItem extends StatelessWidget {
  final Duration recordedDuration;
  final int millis;

  TimerItem(this.recordedDuration, this.millis);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
//        Text(recordedDuration.toString())
          Text(recordedDuration.inHours.toString().padLeft(2, '0')),
          Text(":"),
          Text((recordedDuration.inMinutes % 60).toString().padLeft(2, '0')),
          Text(":"),
          Text((recordedDuration.inSeconds % 60).toString().padLeft(2, '0')),
          Text("."),
          Text(millis.toString().padLeft(3, '0')),
        ],
      ),
    );
  }
}
