import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const WideButton({Key key, this.onPressed, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: RaisedButton(
          color: Colors.blue,
          child: child,
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }
}
