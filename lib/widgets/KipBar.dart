import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProfileWidget.dart';

class KipBar extends StatefulWidget {
  KipBarState createState() => KipBarState();
}

class KipBarState extends State<KipBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0x55555555)),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.menu),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Search in notes"),
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.border_all),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ProfileWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
