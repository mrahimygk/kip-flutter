import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kip/widgets/MenuItem.dart';
import 'package:kip/widgets/MenuShadows.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage>
    with TickerProviderStateMixin {
  var _scaffoldKey = GlobalKey(debugLabel: "parentScaffold");
  AnimationController leftMenuAnimController;
  Animation<Offset> leftMenuOffsetAnim;
  AnimationController rightMenuAnimController;
  Animation<Offset> rightMenuOffsetAnim;
  Color noteColor = Colors.white;
  List<NoteColorModel> noteColors = [
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blueGrey,
    Colors.indigo,
    Colors.deepPurple,
    Colors.purple,
    Colors.grey,
  ].map((color) => NoteColorModel(color.withAlpha(200), color)).toList();

  @override
  void initState() {
    leftMenuAnimController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    leftMenuOffsetAnim =
        Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 1)).animate(
            CurvedAnimation(
                parent: leftMenuAnimController, curve: Curves.decelerate));

    rightMenuAnimController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    rightMenuOffsetAnim =
        Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 1)).animate(
            CurvedAnimation(
                parent: rightMenuAnimController, curve: Curves.decelerate));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    leftMenuAnimController.dispose();
    rightMenuAnimController.dispose();
  }

  bool isLeftMenuOpen = false;

  toggleShowLeftMenu() {
    if (isRightMenuOpen) toggleShowRightMenu();
    if (!isLeftMenuOpen) {
      leftMenuAnimController.forward();
    } else {
      leftMenuAnimController.reverse();
    }

    isLeftMenuOpen = !isLeftMenuOpen;
  }

  bool isRightMenuOpen = false;

  toggleShowRightMenu() {
    if (isLeftMenuOpen) toggleShowLeftMenu();
    if (!isRightMenuOpen) {
      rightMenuAnimController.forward();
    } else {
      rightMenuAnimController.reverse();
    }

    isRightMenuOpen = !isRightMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    //TODO: get predefined data here: flag for added default checkboxes...
    return WillPopScope(
      onWillPop: () async {
        if (!isLeftMenuOpen && !isRightMenuOpen) return true;
        if (isLeftMenuOpen) toggleShowLeftMenu();
        if (isRightMenuOpen) toggleShowRightMenu();
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
                          MenuItem(
                            color: noteColor,
                            onPress: () {},
                            icon: Icons.photo_camera,
                            text: "Take photo",
                          ),
                          MenuItem(
                            color: noteColor,
                            onPress: () {},
                            icon: Icons.image,
                            text: "Choose image",
                          ),
                          MenuItem(
                            color: noteColor,
                            onPress: () {
                              toggleShowLeftMenu();
                              Navigator.of(context).pushNamed("/addDrawing");
                            },
                            icon: Icons.brush,
                            text: "Drawing",
                          ),
                          MenuItem(
                            color: noteColor,
                            onPress: () {},
                            icon: Icons.mic,
                            text: "Recording",
                          ),
                          MenuItem(
                            color: noteColor,
                            onPress: () {},
                            icon: Icons.check_box,
                            text: "Checboxes",
                          ),
                          Container(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// right menu
              Align(
                alignment: Alignment.bottomLeft,
                child: SlideTransition(
                  position: rightMenuOffsetAnim,
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
                          MenuItem(
                            color: noteColor,
                            onPress: () {},
                            icon: Icons.delete,
                            text: "Delete",
                          ),
                          MenuItem(
                            color: noteColor,
                            onPress: () {},
                            icon: Icons.content_copy,
                            text: "Make a copy",
                          ),
                          MenuItem(
                            color: noteColor,
                            onPress: () {
                              toggleShowLeftMenu();
                              Navigator.of(context).pushNamed("/addDrawing");
                            },
                            icon: Icons.share,
                            text: "Send",
                          ),
                          MenuItem(
                            color: noteColor,
                            onPress: () {},
                            icon: Icons.label_outline,
                            text: "Labels",
                          ),
                          Container(
                            height: 48,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: noteColors.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: GestureDetector(
                                    onTapUp: (d) {
                                      setState(() {
                                        noteColor =
                                            noteColors[index].applyingColor;
                                      });
                                    },
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      color: noteColors[index].showingColor,
                                    ),
                                  ),
                                );
                              },
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
                      boxShadow: MenuShadows().get(
                        makeShadowColor(noteColor),
                      ),
                    ),
                    child: Material(
                      color: noteColor,
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
                                onPressed: () {
                                  toggleShowRightMenu();
                                },
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

class NoteColorModel {
  final Color showingColor;
  final Color applyingColor;

  NoteColorModel(this.showingColor, this.applyingColor);
}