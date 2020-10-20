import 'package:flutter/material.dart';
import 'package:kip/widgets/app_drawer.dart';
import 'package:kip/widgets/bar.dart';

class ArchivedPages extends StatelessWidget {
  //Global Key to handle scaffold's drawer
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: AppDrawer(),
        body: Column(
          children: [
            KipBar(
              gKey: _key,
            ),
            Expanded(
              child: Center(
                child: Text('Archived Page'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
