import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kip/widgets/brush_size_item.dart';
import 'package:kip/widgets/color_item.dart';
import 'package:kip/widgets/grid_type_item.dart';
import 'package:kip/widgets/menu_shadows.dart';
import 'package:kip/widgets/paint_surface.dart';

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
  final brushSizeList = List<BrushSizeModel>();
  final brushColorList = List<BrushColorModel>();
  final gridTypeList = List<GridTypeModel>();
  GridType gridType = GridType.NONE;

  @override
  void initState() {
    drawingMenuAnimController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    drawingMenuOffsetAnim =
        Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 0.6)).animate(
            CurvedAnimation(
                parent: drawingMenuAnimController, curve: Curves.decelerate));

    super.initState();

    _finished = false;
    brushSizeList.add(BrushSizeModel(false, BrushSize._1, 1.0));
    brushSizeList.add(BrushSizeModel(false, BrushSize._2, 2.0));
    brushSizeList.add(BrushSizeModel(false, BrushSize._5, 5.0));
    brushSizeList.add(BrushSizeModel(false, BrushSize._10, 10.0));
    brushSizeList.add(BrushSizeModel(false, BrushSize._15, 15.0));
    brushSizeList.add(BrushSizeModel(false, BrushSize._20, 20.0));
    brushSizeList.add(BrushSizeModel(false, BrushSize._30, 30.0));

    brushColorList.add(BrushColorModel(false, Colors.yellow));
    brushColorList.add(BrushColorModel(false, Colors.green));
    brushColorList.add(BrushColorModel(false, Colors.blue));
    brushColorList.add(BrushColorModel(false, Colors.black));
    brushColorList.add(BrushColorModel(false, Colors.pink));
    brushColorList.add(BrushColorModel(false, Colors.purple));
    brushColorList.add(BrushColorModel(false, Colors.red));

    gridTypeList.add(GridTypeModel(false, GridType.NONE, 0, 20));
    gridTypeList.add(GridTypeModel(false, GridType.SQUARE, 1, 20));
    gridTypeList.add(GridTypeModel(false, GridType.RULERS, 2, 20));
    gridTypeList.add(GridTypeModel(false, GridType.DOTS, 3, 20));

    _drawingController = _newController();

    selectBrushColor(brushColorList.elementAt(2).color, 2);
    selectBrushSize(brushSizeList.elementAt(3).size, 3);
    selectGridType(gridTypeList.elementAt(0).gridType, 0);
  }

  PainterController _newController() {
    PainterController controller = new PainterController(20);
    controller.thickness = 0;
    controller.gridType = gridType;
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
                          changeGrid(context);
                          return;
                        case PopUpMenu.Change_grid:
                          changeGrid(context);
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
                          value: gridType == GridType.NONE
                              ? PopUpMenu.Show_grid
                              : PopUpMenu.Change_grid,
                          child: chooseGridTypeWidget(),
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
            ///main drawing surface
            PaintSurface(_drawingController),

            /// bottom menu(brushes)
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: drawingMenuOffsetAnim,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: MenuShadows().get(Colors.white),
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
                                  children: makeColorItemWidgets()),
//                              GridView.count(
//                                crossAxisCount: 6,
//                                children: makeColorItemWidgets(),
//                              ),
                              Container(
                                color: Colors.grey.shade100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: makeBrushWidgets(),
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

  void selectBrushSize(double size, int index) {
    _drawingController.thickness = size;
    setState(() {
      brushSizeList.forEach((b) {
        b.isSelected = false;
      });
      brushSizeList[index].isSelected = true;
    });
  }

  void selectBrushColor(Color color, int index) {
    _drawingController.drawColor = color;
    setState(() {
      brushColorList.forEach((b) {
        b.isSelected = false;
      });
      brushColorList[index].isSelected = true;
    });
  }

  List<Widget> makeBrushWidgets() {
    final widgetList = List<Widget>();
    brushSizeList.asMap().forEach((index, b) {
      widgetList.add(
        BrushSizeItem(
          item: b,
          onPress: () {
            selectBrushSize(b.size, index);
          },
        ),
      );
    });
    return widgetList;
  }

  List<Widget> makeColorItemWidgets() {
    final widgetList = List<Widget>();
    brushColorList.asMap().forEach((index, b) {
      widgetList.add(
        ColorItem(
          item: b,
          onPress: () {
            selectBrushColor(b.color, index);
          },
        ),
      );
    });
    return widgetList;
  }

  Widget chooseGridTypeWidget() {
    var text = "Show";
    if (gridType != GridType.NONE) text = "Change";
    return Text("$text grid");
  }

  void changeGrid(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text("Change Grid"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Dismiss"),
            )
          ],
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: gridTypeList
                      .map(
                        (item) => GridTypeItem(
                          onPress: () {
                            setState(() {
                              selectGridType(item.gridType, item.index);
                            });
                          },
                          item: item,
                        ),
                      )
                      .toList(),
                ),
                Slider(
                  value: 20,
                  min: 10,
                  max: 50,
                  onChanged: (value) {
                    setState(() {
//                    space = value;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectGridType(GridType type, int index) {
    setState(() {
      gridType = type;
      _drawingController.gridType = gridType;

      gridTypeList.forEach((item) {
        item.isSelected = false;
      });
      gridTypeList[index].isSelected = true;
    });
  }
}

enum PopUpMenu { Show_grid, Change_grid, Grab_image_text, Send, Delete }

enum BrushSize { _1, _2, _5, _10, _15, _20, _30 }

class BrushSizeModel {
  final BrushSize sizeEnum;
  final double size;
  bool isSelected;

  BrushSizeModel(this.isSelected, this.sizeEnum, this.size);
}

class BrushColorModel {
  final Color color;
  bool isSelected;

  BrushColorModel(this.isSelected, this.color);
}

class GridTypeModel {
  final GridType gridType;
  bool isSelected;
  final int index;

  final int space;

  GridTypeModel(this.isSelected, this.gridType, this.index, this.space);
}
