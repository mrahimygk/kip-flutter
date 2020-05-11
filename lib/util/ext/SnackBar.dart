import 'package:flutter/material.dart';

extension CustomSnackBar on GlobalKey {
  void showRowSnackBar(Widget child) {
    (this as ScaffoldState).showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
