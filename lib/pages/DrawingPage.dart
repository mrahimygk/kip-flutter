import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kip/widgets/MenuShadows.dart';

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage>
    with SingleTickerProviderStateMixin {
  var _scaffoldKey = GlobalKey(debugLabel: "parentScaffold");
  AnimationController drawingMenuAnimController;
  Animation<Offset> drawingMenuOffsetAnim;

  @override
  void initState() {
    drawingMenuAnimController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    drawingMenuOffsetAnim =
        Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 0.7)).animate(
            CurvedAnimation(
                parent: drawingMenuAnimController, curve: Curves.decelerate));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    drawingMenuAnimController.dispose();
  }

  bool isDrawingMenuOpen = false;

  toggleShowDrawingMenu() {
    if (!isDrawingMenuOpen) {
      drawingMenuAnimController.forward();
    } else {
      drawingMenuAnimController.reverse();
    }

    isDrawingMenuOpen = !isDrawingMenuOpen;
  }

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
                    icon: Icon(Icons.undo),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.redo),
                    onPressed: () {},
                  ),
                  PopupMenuButton(
                    onSelected: (value) {
                      print((value as PopUpMenu).index);
                      print("value:$value");
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuItem>[
                        PopupMenuItem(
                          value: PopUpMenu.Show_grid,
                          child: Text("Show grid"),
                        ),
                        PopupMenuItem(
                          value: PopUpMenu.Grab_image_text,
                          child: Text("Grab image text"),
                        ),
                        PopupMenuItem(
                          value: PopUpMenu.Send,
                          child: Text("Send"),
                        ),
                        PopupMenuItem(
                          value: PopUpMenu.Delete,
                          child: Text("Delete"),
                        )
                      ].toList();
                    },
                  )
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
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: drawingMenuOffsetAnim,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: MenuShadows().get(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                            onTapUp: (d) {
                              toggleShowDrawingMenu();
                            },
                            child: Container(
                              child: isDrawingMenuOpen
                                  ? Icon(Icons.arrow_drop_down)
                                  : Icon(Icons.arrow_drop_up),
                            )),
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
          ],
        ),
      ),
    );
  }
}

enum PopUpMenu { Show_grid, Grab_image_text, Send, Delete }
