import 'package:flutter/cupertino.dart';

class ProfileWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 32.0,
      height: 32.0,
      child: ClipOval(
        child: Image.network("https://image.shutterstock.com/image-photo/white-transparent-leaf-on-mirror-600w-1029171697.jpg"),
      ),
    );
  }
}