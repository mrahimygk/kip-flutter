import 'package:flutter/material.dart';
import 'package:kip/widgets/custom_text_widget.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _heigth = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(
          text: 'Support',
          size: _heigth * 0.035,
          color: Colors.grey,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text('Suppot Page'),
      ),
    );
  }
}
