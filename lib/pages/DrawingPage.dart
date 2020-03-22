import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kip/widgets/ColorItem.dart';
import 'package:kip/widgets/MenuShadows.dart';
import 'package:kip/widgets/PaintSurface.dart';

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage>
    with SingleTickerProviderStateMixin {
  var _scaffoldKey = GlobalKey(debugLabel: "parentScaffold");
  AnimationController drawingMenuAnimController;
  Animation<Offset> drawingMenuOffsetAnim;
  PainterController _drawingController;
  bool _finished;
  double brushSize = 5.0;

  @override
  void initState() {
    drawingMenuAnimController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    drawingMenuOffsetAnim =
        Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 0.7)).animate(
            CurvedAnimation(
                parent: drawingMenuAnimController, curve: Curves.decelerate));

    super.initState();

    _finished = false;
    _drawingController = _newController();
  }

  PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = brushSize;
    controller.backgroundColor = Colors.grey.shade300;
    return controller;
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
                    onPressed: () {
                      _drawingController.undo();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.redo),
                    onPressed: () {
                      _drawingController.redo();
                    },
                  ),
                  PopupMenuButton(
                    onSelected: (value) {
                      switch (value as PopUpMenu) {
                        case PopUpMenu.Delete:
                          _drawingController.clear();
                          break;
                        case PopUpMenu.Show_grid:
                          return;
                        case PopUpMenu.Grab_image_text:
                          return;
                        case PopUpMenu.Send:
                          return;
                      }
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
            PaintSurface(_drawingController),

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
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.brush,
                              color: Colors.black87,
                            ),
                            Icon(
                              Icons.brush,
                              color: Colors.black87,
                            ),
                            Icon(
                              Icons.brush,
                              color: Colors.black87,
                            ),
                            Icon(
                              Icons.brush,
                              color: Colors.black87,
                            ),
                          ],
                        ),
                        Container(height: 12),
                        Container(
                          color: Colors.grey.shade200,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                  ColorItem(itemColor: Colors.blue),
                                ],
                              ),
                              Container(
                                color: Colors.grey.shade100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    ColorItem(
                                      itemColor: Colors.black,
                                      size: 1,
                                      onPress: () {
                                        selectBrushSize(1);
                                      },
                                    ),
                                    ColorItem(
                                      itemColor: Colors.black,
                                      size: 2,
                                      onPress: () {
                                        selectBrushSize(2);
                                      },
                                    ),
                                    ColorItem(
                                      itemColor: Colors.black,
                                      size: 5,
                                      onPress: () {
                                        selectBrushSize(5);
                                      },
                                    ),
                                    ColorItem(
                                      itemColor: Colors.black,
                                      size: 10,
                                      onPress: () {
                                        selectBrushSize(10);
                                      },
                                    ),
                                    ColorItem(
                                      itemColor: Colors.black,
                                      size: 15,
                                      onPress: () {
                                        selectBrushSize(15);
                                      },
                                    ),
                                    ColorItem(
                                      itemColor: Colors.black,
                                      size: 20,
                                      onPress: () {
                                        selectBrushSize(20);
                                      },
                                    ),
                                    ColorItem(
                                      itemColor: Colors.black,
                                      size: 30,
                                      onPress: () {
                                        selectBrushSize(30);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
    );
  }

  void selectBrushSize(double size) {
    _drawingController.thickness = size;
  }
}

enum PopUpMenu { Show_grid, Grab_image_text, Send, Delete }
enum BrushSize { _1, _2, _5, _10, _15, _20, _30 }
