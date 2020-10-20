import 'package:flutter/material.dart';
import 'package:kip/widgets/custom_text_widget.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomTextWidget(
          text: 'Settings',
          size: _heigth * 0.03,
          color: Colors.grey,
        ),
        elevation: 2,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
