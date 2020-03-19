import 'package:flutter/cupertino.dart';

class BorderedContainer extends StatelessWidget {
  final Widget child;

  const BorderedContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0x55555555)),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: this.child,
    );
  }
}
