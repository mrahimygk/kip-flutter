import 'dart:ui';

class MakeShaodowColor {
  static Color makeShadow(Color color) {
    return color
        .withRed(color.red - 50)
        .withBlue(color.blue - 50)
        .withGreen(color.green - 50);
  }
}
