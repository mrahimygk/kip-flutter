import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Color color;
  final VoidCallback onPress;
  final IconData icon;
  final String text;

  const MenuItem({Key key, this.color, this.onPress, this.icon, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: color,
      child: InkWell(
        onTap: () {
          onPress();
        },
        onLongPress: () {},
        canRequestFocus: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  icon,
                  color: Colors.black87,
                ),
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
