import 'package:flutter/material.dart';
import 'package:kip/pages/archived_page.dart';
import 'package:kip/pages/deleted_page.dart';
import 'package:kip/pages/drawing_page.dart';
import 'package:kip/pages/main_page.dart';
import 'package:kip/pages/login_page.dart';
import 'package:kip/pages/reminder_page.dart';
import 'package:kip/pages/settings_page.dart';
import 'package:kip/pages/support_page.dart';

import 'pages/add_note_page.dart';

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
        '/login': (BuildContext inContext) => LoginPage(),
        '/addNote': (BuildContext inContext) => AddNotePage(),
        '/addDrawing': (BuildContext inContext) => DrawingPage(),
        '/settings': (BuildContext inContext) => SettingsPage(),
        '/support': (BuildContext inContext) => SupportPage(),
      },
    );
  }
}
