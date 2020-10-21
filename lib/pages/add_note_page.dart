import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kip/blocs/note_bloc.dart';
import 'package:kip/models/add_note_page_arguments.dart';
import 'package:kip/models/note/checkbox_model.dart';
import 'package:kip/models/note/note_model.dart';
import 'package:kip/models/note/voice_model.dart';
import 'package:kip/util/make_shadow_colo.dart';
import 'package:kip/widgets/left_menu_widget.dart';
import 'package:kip/widgets/menu_shadows.dart';
import 'package:kip/widgets/right_menu_widget.dart';
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
  Timer _debounce;

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
  bool hasAddedNewImageAlready = false;
  bool hasAddedNewVoiceAlready = false;

  TextEditingController _noteTitleController;
  TextEditingController _noteContentController;

  final labelList = List<String>();
  NoteModel note;

  final Uuid uuid = Uuid();
  bool hasParsedArgs = false;

  @override
  void initState() {
    leftMenuAnimController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    leftMenuOffsetAnim =
        Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 1)).animate(
      CurvedAnimation(
        parent: leftMenuAnimController,
        curve: Curves.decelerate,
      ),
    );

    rightMenuAnimController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    rightMenuOffsetAnim =
        Tween<Offset>(end: Offset.zero, begin: const Offset(0.0, 1)).animate(
      CurvedAnimation(
        parent: rightMenuAnimController,
        curve: Curves.decelerate,
      ),
    );

    super.initState();
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

    if (!hasParsedArgs) {
      if (args.shouldAddDrawing && !hasStartedNewDrawing) {
        newDrawing();
        hasStartedNewDrawing = true;
      }

      if (args.note == null) {
        note = new NoteModel(
          uuid.v4(),
          "",
          "",
          Colors.white,
          List<String>(),
          List<VoiceModel>(),
          //TODO
          List<CheckboxModel>(),
          labelList,
          //TODO
          false,
          DateTime.now().toString(),
          DateTime.now().toString(),
        );
        selectNoteColor(0);

        if (args.shouldAddCheckboxes && !hasAddedNewCheckboxAlready) {
          addCheckBox();
          hasAddedNewCheckboxAlready = true;
        }

        if (args.imagePath.isNotEmpty && !hasAddedNewImageAlready) {
          addImage(args.imagePath);
          hasAddedNewImageAlready = true;
        }

        if (args.voice != null && !hasAddedNewVoiceAlready) {
          addVoice(args.voice);
          hasAddedNewVoiceAlready = true;
        }

        noteBloc.insertNote(note);
      } else {
        setState(() {
          note = args.note;
        });
      }

      _noteTitleController = TextEditingController(text: note.title);
      _noteTitleController.addListener(() {
        if (_debounce?.isActive ?? false) _debounce.cancel();
        _debounce = Timer(const Duration(milliseconds: 313), () {
          note.title = _noteTitleController.text;
          noteBloc.updateNote(note);
        });
      });

      _noteContentController = TextEditingController(text: note.content);
      _noteContentController.addListener(() {
        if (_debounce?.isActive ?? false) _debounce.cancel();
        _debounce = Timer(const Duration(milliseconds: 313), () {
          note.content = _noteContentController.text;
          noteBloc.updateNote(note);
        });
      });

      listenOnCheckBoxChanges();

      hasParsedArgs = true;
    }

    return WillPopScope(
      onWillPop: () async {
        if (!isLeftMenuOpen && !isRightMenuOpen) {
          //discard empty note
          if (isNoteEmpty()) noteBloc.deleteNote(note);
          Navigator.of(context).pop(isNoteEmpty());
          return false;
        }
        if (isLeftMenuOpen) toggleShowLeftMenu();
        if (isRightMenuOpen) toggleShowRightMenu();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: note.color,

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
                        Navigator.of(context).pop(isNoteEmpty());
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
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
                  children: makeMainChildren()),

              /// left menu
              Align(
                alignment: Alignment.bottomLeft,
                child: LeftMenuWidget(
                  addCheckBox: addCheckBox,
                  leftMenuOffsetAnim: leftMenuOffsetAnim,
                  note: note,
                  toggleShowLeftMenu: toggleShowLeftMenu,
                ),
              ),

              /// right menu
              Align(
                alignment: Alignment.bottomLeft,
                child: RightMenuWidget(
                  note: note,
                  noteColors: noteColors,
                  rightMenuOffsetAnim: rightMenuOffsetAnim,
                  toggleShowLeftMenu: toggleShowLeftMenu,
                  onTap: (int index) {
                    setState(() {
                      selectNoteColor(index);
                    });
                    noteBloc.updateNote(note);
                  },
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
                        MakeShaodowColor.makeShadow(note.color),
                      ),
                    ),
                    child: Material(
                      color: note.color,
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

  void selectNoteColor(int index) {
    note.color = noteColors[index].applyingColor;
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
    final checkbox = CheckboxModel(uuid.v4(), "", 0, false, false);

    setState(() {
      note.checkboxList.add(checkbox);
    });

    addListenerToCheckBoxChanges(note.checkboxList.last);
  }

  void addImage(String imagePath) {
    setState(() {
      note.drawingList.add(imagePath);
    });

    //TODO: add click listener
  }

  void addVoice(VoiceModel voice) {
    setState(() {
      note.voiceList.add(voice);
    });

    //TODO: add click listener
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
                      start: checkBoxItem.indent * 32.0),
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

  void listenOnCheckBoxChanges() {
    note.checkboxList.forEach((element) {
      addListenerToCheckBoxChanges(element);
    });
  }

  void addListenerToCheckBoxChanges(CheckboxModel element) {
    element.controller.addListener(() {
      if (_debounce?.isActive ?? false) _debounce.cancel();
      _debounce = Timer(const Duration(milliseconds: 313), () {
        noteBloc.updateNote(note);
      });
    });
  }

  @override
  void dispose() {
    leftMenuAnimController.dispose();
    rightMenuAnimController.dispose();
    _noteContentController.dispose();
    _noteTitleController.dispose();
    note.checkboxList.forEach((c) {
      //c.dispose();
    });
    super.dispose();
  }

  List<Widget> makeMainChildren() {
    final list = List<Widget>();
    if (note.drawingList.isNotEmpty) {
      note.drawingList.forEach((element) {
        list.add(
          Image.file(File(element)),
        );
      });
    }

    if (note.voiceList.isNotEmpty) {
      note.voiceList.forEach((element) {
        list.add(Row(
          children: [
            IconButton(
              icon: Icon(Icons.play_circle_outline),
              onPressed: () {
                // TODO: Play sound
              },
            ),
            GestureDetector(
                onLongPress: () {
                  // TODO: EDIT file name
                },
                child: Text(element.filename))
          ],
        ));
      });
    }

    list.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _noteTitleController,
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration.collapsed(
          hintText: "Title",
        ),
      ),
    ));

    if (note.checkboxList.isEmpty) {
      list.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: _noteContentController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration.collapsed(
            hintText: "Note",
          ),
        ),
      ));
    } else {
      list.add(Expanded(child: makeCheckBoxList()));
    }

    return list;
  }

  bool isNoteEmpty() {
    return note.title.isEmpty &&
        note.checkboxList.isEmpty &&
        note.content.isEmpty &&
        note.drawingList.isEmpty &&
        note.labelList.isEmpty &&
        note.voiceList.isEmpty;
  }
}

class NoteColorModel {
  final Color showingColor;
  final Color applyingColor;
  bool isSelected;

  NoteColorModel(this.showingColor, this.applyingColor, this.isSelected);
}
