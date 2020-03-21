import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuShadows {
  get() {
    return <BoxShadow>[
      BoxShadow(
          offset: Offset(2.0, 2.0),
          color: Colors.grey.shade300,
          blurRadius: 4.0,
          spreadRadius: 2.0)
    ];
  }
}
