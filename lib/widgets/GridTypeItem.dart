import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kip/pages/DrawingPage.dart';

class GridTypeItem extends StatelessWidget {
  final VoidCallback onPress;
  final GridTypeModel item;

  GridTypeItem({Key key, this.onPress, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemSize = 64.0;
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Stack(
        children: <Widget>[
          ///actual circle
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: itemSize,
                width: itemSize,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          ///selected indicator
          item.isSelected
              ? Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, border: Border.all()),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
