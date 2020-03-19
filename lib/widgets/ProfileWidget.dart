import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kip/models/User.dart';

class ProfileWidget extends StatelessWidget {
  final User user;
  final VoidCallback onPress;

  const ProfileWidget({Key key, this.user, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return user == null
        ? IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              onPress();
            },
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatar),
          );
  }
}
