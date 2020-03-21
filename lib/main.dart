import 'package:flutter/material.dart';
import 'package:kip/pages/KipMainPage.dart';
import 'package:kip/pages/LoginPage.dart';

import 'pages/AddNotePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KipMainPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext inContext) => KipMainPage(),
        '/login': (BuildContext inContext)=> LoginPage(),
        '/addNote': (BuildContext inContext)=> AddNotePage(),
      },
    );
  }
}