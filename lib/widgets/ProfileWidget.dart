import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kip/blocs/UserBloc.dart';
import 'package:kip/models/User.dart';

class ProfileWidget extends StatelessWidget {
  final VoidCallback onPress;

  ProfileWidget({Key key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = UserBloc();

    return StreamBuilder(
      stream: userBloc.user,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTapUp: (t) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Logout'),
                        content: Text('Please confirm the logout action'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Logout"),
                            onPressed: () {
                              userBloc.deleteUser(snapshot.data);
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          )
                        ],
                      ));
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data.avatar),
            ),
          );
        } else {
          return IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              onPress();
            },
          );
        }
      },
    );
  }
}
