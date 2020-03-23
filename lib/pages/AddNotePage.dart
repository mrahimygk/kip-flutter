import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kip/widgets/MenuShadows.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage>
    with SingleTickerProviderStateMixin {
  var _scaffoldKey = GlobalKey(debugLabel: "parentScaffold");
  AnimationController leftMenuAnimController;
  Animation<Offset> leftMenuOffsetAnim;
  Color noteColor = Colors.red;

  @override
  void initState() {
    leftMenuAnimController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    leftMenuOffsetAnim =
        Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 1)).animate(
            CurvedAnimation(
                parent: leftMenuAnimController, curve: Curves.decelerate));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    leftMenuAnimController.dispose();
  }

  bool isLeftMenuOpen = false;

  toggleShowLeftMenu() {
    if (!isLeftMenuOpen) {
      leftMenuAnimController.forward();
    } else {
      leftMenuAnimController.reverse();
    }

    isLeftMenuOpen = !isLeftMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    //TODO: get predefined data here: flag for added default checkboxes...
    return WillPopScope(
      onWillPop: () async {
        if (!isLeftMenuOpen) return true;
        toggleShowLeftMenu();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: noteColor,

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

              /// left menu
              Align(
                alignment: Alignment.bottomLeft,
                child: SlideTransition(
                  position: leftMenuOffsetAnim,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 48.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: noteColor,
                        boxShadow:
                            MenuShadows().get(makeShadowColor(noteColor)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(height: 8),
                          Material(
                            color: noteColor,
                            child: InkWell(
                              onTap: () {},
                              onLongPress: () {},
                              canRequestFocus: true,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
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
                          ),
                          Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {},
                              onLongPress: () {},
                              canRequestFocus: true,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
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
                          ),
                          Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                toggleShowLeftMenu();
                                Navigator.of(context).pushNamed("/addDrawing");
                              },
                              onLongPress: () {},
                              canRequestFocus: true,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
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
                          ),
                          Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {},
                              onLongPress: () {},
                              canRequestFocus: true,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
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
                          ),
                          Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {},
                              onLongPress: () {},
                              canRequestFocus: true,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
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
                          ),
                          Container(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// Bottom bar
              Align(
                alignment: Alignment.bottomCenter,
                child: PreferredSize(
                  preferredSize: Size.fromHeight(48),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: MenuShadows().get(
                        makeShadowColor(noteColor),
                      ),
                    ),
                    child: Material(
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  toggleShowLeftMenu();
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color makeShadowColor(Color color) {
    return color
        .withRed(noteColor.red - 50)
        .withBlue(noteColor.blue - 50)
        .withGreen(noteColor.green - 50);
  }
}
