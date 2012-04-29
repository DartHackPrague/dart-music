class DartMath {

  static int Random(int min, int max) {
    return (min + (Math.random() * (max - min))).round();
  }

}
