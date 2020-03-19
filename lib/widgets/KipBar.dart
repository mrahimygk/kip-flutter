import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kip/models/User.dart';
import 'package:kip/services/db/DatabaseProvider.dart';
import 'package:kip/services/repo/UserRepoImpl.dart';
import 'package:kip/widgets/BorderedContainer.dart';

import 'ProfileWidget.dart';

class KipBar extends StatefulWidget {
  final VoidCallback onRequestLogin;

  const KipBar({Key key, this.onRequestLogin}) : super(key: key);
  KipBarState createState() => KipBarState();
}

class KipBarState extends State<KipBar> {
  final userRepo = UserRepoImpl(DatabaseProvider.get);
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRepo.getFromDb().then((user) {
      setState(() {
        if (user != null) this.user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: BorderedContainer(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  //TODO: menu
                },
              ),
              Flexible(
                  child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Search in notes"),
              )),
              IconButton(
                icon: Icon(Icons.border_all),
                onPressed: () {
                  //TODO: tile/table view
                },
              ),
              ProfileWidget(user:user, onPress: widget.onRequestLogin,)
            ],
          ),
        ),
      ),
    );
  }
}
