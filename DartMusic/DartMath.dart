class DartMath {

  static int Random(int min, int max) {
    int value = (min + (Math.random() * (max - min))).round();
    return value;
  }

}
