import 'package:flutter/material.dart';
import 'package:kip/widgets/custom_text_widget.dart';

class CustomRowWithIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const CustomRowWithIcon({
    Key key,
    @required this.icon,
    @required this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _heigth = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: _heigth * 0.02,
        horizontal: _heigth * 0.025,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: _heigth * 0.035,
          ),
          SizedBox(
            width: 20,
          ),
          CustomTextWidget(
            text: label,
            size: _heigth * 0.02,
          ),
        ],
      ),
    );
  }
}
