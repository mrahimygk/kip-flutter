import 'package:flutter/material.dart';
import 'package:kip/widgets/KipBar.dart';
import 'package:kip/widgets/NoteItem.dart';

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
//        '/login': (BuildContext inContext)=> LoginPage(),
      },
    );
  }
}

class KipMainPage extends StatefulWidget {
  @override
  _KipMainPageState createState() => _KipMainPageState();
}

class _KipMainPageState extends State<KipMainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.check_box),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.aspect_ratio),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.mic),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.photo),
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            KipBar(
              onRequestLogin: onNavigateToLogin(context),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                  NoteItem(
                    child: ListTile(leading: Text("ffff")),
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: addNote,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  addNote() {}

  onNavigateToLogin(BuildContext context) {
//    Navigator.push(context, );
  }
}
