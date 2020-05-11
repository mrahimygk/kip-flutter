import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kip/pages/drawing_page.dart';
import 'package:kip/widgets/paint_surface.dart';
import 'package:kip/widgets/painter/grid_widget_painter.dart';

class GridTypeItem extends StatelessWidget {
  final VoidCallback onPress;
  final GridTypeModel item;

  GridTypeItem({Key key, this.onPress, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemSize = 64.0;
    const padding = 24.0;

    return InkWell(
      onTap: () {
        onPress();
      },
      child: Stack(
        children: <Widget>[
          ///actual circle
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(padding),
              child: Container(
                height: itemSize,
                width: itemSize,
                child: ClipOval(
                  child: CustomPaint(
                    painter: GridWidgetPainter(item.gridType, item.space),
                  ),
                ),

                ///outer border
                decoration:
                    BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: chooseGridText(),
          ),

          ///selected indicator
          if (item.isSelected)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(padding),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        height: itemSize,
                        width: itemSize,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 2.0)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget chooseGridText() {
    String text = "";
    switch (item.gridType) {
      case GridType.NONE:
        text = "None";
        break;
      case GridType.SQUARE:
        text = "Square";
        break;
      case GridType.DOTS:
        text = "Dots";
        break;
      case GridType.RULERS:
        text = "Rulers";
        break;
    }
    return Text(text);
  }
}
