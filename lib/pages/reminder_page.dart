import 'package:flutter/material.dart';

class RemindersPage extends StatelessWidget {
  //Global Key to handle scaffold's drawer
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Reminders Page'),
    );
  }
}
