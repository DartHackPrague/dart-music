class DartMath {

  static int Random(int min, int max) {
    var randVal = min + (Math.random()*(max - min));
    var strVal = randVal.toString().split(".")[0];
    var result = Math.parseInt(strVal);
    return result;
  }

}
