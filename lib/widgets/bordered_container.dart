import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  final Widget child;
  final Color color;

  const BorderedContainer({Key key, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: this.color,
          border: Border.all(color: Color(0x55555555)),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: this.child,
    );
  }
}
