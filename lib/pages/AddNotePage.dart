import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  var _scaffoldKey = GlobalKey(debugLabel: "parentScaffold");

  @override
  Widget build(BuildContext context) {
    //TODO: get predefined data here: flag for added default checkboxes...
    return SafeArea(
      child: Scaffold(
        ///top menu
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back)),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.add_alert),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.archive),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ]),
        ),
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            ///main input fields
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration.collapsed(
                      hintText: "Title",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                      hintText: "Note",
                    ),
                  ),
                )
              ],
            ),

            /// Bottom bar
            Align(
              alignment: Alignment.bottomCenter,
              child: PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () {
                            //TODO: show menu
                          },
                        ),
                        Expanded(
                            child: Text(
                          'Edited 00:00 PM',
                          textAlign: TextAlign.center,
                        )),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.menu),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// left menu
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        onLongPress: () {},
                        canRequestFocus: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black87,
                                ),
                              ),
                              Text("Take photo"),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        onLongPress: () {},
                        canRequestFocus: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.image,
                                  color: Colors.black87,
                                ),
                              ),
                              Text("Choose image"),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        onLongPress: () {},
                        canRequestFocus: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.brush,
                                  color: Colors.black87,
                                ),
                              ),
                              Text("Drawing"),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        onLongPress: () {},
                        canRequestFocus: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.mic,
                                  color: Colors.black87,
                                ),
                              ),
                              Text("Recording"),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        onLongPress: () {},
                        canRequestFocus: true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.check_box,
                                  color: Colors.black87,
                                ),
                              ),
                              Text("Checboxes"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
