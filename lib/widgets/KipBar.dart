import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProfileWidget.dart';

class KipBar extends StatefulWidget {
  KipBarState createState() => KipBarState();
}

class KipBarState extends State<KipBar> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.menu),
            Flexible(child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search in notes"
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Icon(Icons.border_all),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: ProfileWidget(),
            )
          ],
        ),
      ),
    );
  }
}
