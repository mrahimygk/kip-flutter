import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CircleAvatar(
        backgroundImage: NetworkImage(
            "https://image.shutterstock.com/image-photo/white-transparent-leaf-on-mirror-600w-1029171697.jpg"));
  }
}
