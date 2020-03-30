import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kip/models/AddNotePageArguments.dart';
import 'package:kip/models/NoteModel.dart';
import 'package:kip/widgets/MenuItem.dart';
import 'package:kip/widgets/MenuShadows.dart';
import 'package:kip/widgets/NoteColorItem.dart';
import 'package:uuid/uuid.dart';

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
  ].map((color) => NoteColorModel(color.withAlpha(200), color, false)).toList();

  bool hasStartedNewDrawing = false;
  bool hasAddedNewCheckboxAlready = false;

//  TextEditingController _noteTitleController;
//  TextEditingController _noteContentController;

  final NoteModel note = new NoteModel(
    "",
    "",
    Colors.white,
    List<String>(),
    List<String>(),
    List<CheckboxModel>(),
    List<String>(),
    false,
  );

  final Uuid uuid = Uuid();

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

    selectNoteColor(0);
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
    final args =
        ModalRoute.of(context).settings.arguments as AddNotePageArguments;
    if (args.shouldAddDrawing && !hasStartedNewDrawing) {
      newDrawing();
      hasStartedNewDrawing = true;
    }

    if (args.shouldAddCheckboxes && !hasAddedNewCheckboxAlready) {
      addCheckBox();
      hasAddedNewCheckboxAlready = true;
    }

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
//                      controller:,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration.collapsed(
                        hintText: "Title",
                      ),
                    ),
                  ),
                  note.checkboxList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                              hintText: "Note",
                            ),
                          ),
                        )
                      : Expanded(child: makeCheckBoxList())
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
                          note.checkboxList.length > 0
                              ? Container(height: 8)
                              : MenuItem(
                                  color: noteColor,
                                  onPress: () {
                                    toggleShowLeftMenu();
                                    addCheckBox();
                                  },
                                  icon: Icons.check_box,
                                  text: "Checboxes",
                                ),
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
                                return NoteColorItem(
                                  onPress: () {
                                    setState(() {
                                      selectNoteColor(index);
                                    });
                                  },
                                  item: noteColors[index],
                                  index: index,
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
                                ),
                              ),
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

  void selectNoteColor(int index) {
    noteColor = noteColors[index].applyingColor;
    noteColors.forEach((c) {
      c.isSelected = false;
    });
    noteColors[index].isSelected = true;
  }

  void newDrawing() {
    Future.delayed(const Duration(milliseconds: 50), () {
      Navigator.of(context).pushNamed("/addDrawing");
    });
  }

  void addCheckBox() {
    final controller = TextEditingController();
    final checkbox = CheckboxModel(uuid.v4(), "", 0, false, false, controller);

    setState(() {
      note.checkboxList.add(checkbox);
    });
  }

  Widget makeCheckBoxList() {
    return ListView.builder(
        itemCount: note.checkboxList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          //TODO: return a checkbox item
          if (index == note.checkboxList.length) {
            return ListTile(
              onTap: () {
                addCheckBox();
              },
              leading: Icon(Icons.add),
              title: Text("More"),
            );
          } else {
            final checkBoxItem = note.checkboxList[index];

            /// from space to tilda
            RegExp exp = new RegExp(r"[ -~]");
            final text = checkBoxItem.controller.text;
            var isLtr = text.startsWith(exp) || text.isEmpty;
            final decIndentButton = IconButton(
              onPressed: () {
                decreaseIndent(checkBoxItem);
              },
              padding: EdgeInsets.all(0.0),
              iconSize: 16.0,
              icon: isLtr
                  ? Icon(Icons.format_indent_decrease)
                  : Icon(Icons.format_indent_increase),
            );

            final incIndentButton = IconButton(
              onPressed: () {
                increaseIndent(checkBoxItem);
              },
              padding: EdgeInsets.all(0.0),
              iconSize: 16.0,
              icon: isLtr
                  ? Icon(Icons.format_indent_increase)
                  : Icon(Icons.format_indent_decrease),
            );
            return Directionality(
              textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  print(details.delta);
                  if (details.delta.dx > 0.0) {
                    increaseIndent(checkBoxItem);
                  }

                  if (details.delta.dx < 0.0) {
                    decreaseIndent(checkBoxItem);
                  }
                },
                child: ListTile(
                  contentPadding: EdgeInsetsDirectional.only(
                      start: checkBoxItem.indent * 32.0 + 16.0),
                  title: Row(
                    children: <Widget>[
                      checkBoxItem.indent > 0
                          ? decIndentButton
                          : incIndentButton,
                      Checkbox(
                        value: checkBoxItem.checked,
                        onChanged: (value) {
                          setState(() {
                            checkBoxItem.checked = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 16.0),
                          child: TextField(
                            controller: checkBoxItem.controller,
                            decoration: InputDecoration.collapsed(hintText: ""),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  void increaseIndent(checkBoxItem) {
    if (checkBoxItem.indent + 1 <= 1) {
      setState(() {
        checkBoxItem.indent++;
      });
    }
  }

  void decreaseIndent(checkBoxItem) {
    if (checkBoxItem.indent - 1 >= 0) {
      setState(() {
        checkBoxItem.indent--;
      });
    }
  }
}

class NoteColorModel {
  final Color showingColor;
  final Color applyingColor;
  bool isSelected;

  NoteColorModel(this.showingColor, this.applyingColor, this.isSelected);
}
