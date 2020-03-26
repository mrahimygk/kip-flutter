import 'dart:math';

class ReadyMade{

  static Random random = Random();
  static List<int> makeThresholds(int count){

    final thresholds = List<int>();
    for (int i = 0; i < count; i++) {
      thresholds.add(random.nextInt(count) + 1);
    }

    return thresholds;
  }
}