class DartMath {

  static int Random(int min, int max) {
    int value = (min + (Math.random() * (max - min))).round();
    return value;
  }

  static int Average(List numbers) {
    if (numbers == null ) return 0;
    if (numbers.length == 0) return 0;
    if (numbers.length == 1) return numbers[0];

    var len = numbers.length;
    var total = 0;
    var result = 0;
    numbers.forEach(f(number) => total += number);
    result = total / len;
    return result;
  }

  static String getNiceTime(double time) {
    int minutes = (time / 60).floor().toInt();
    int seconds = (time % 60).floor().toInt();
    StringBuffer sb = new StringBuffer();
    sb.add(minutes);
    sb.add(':');
    sb.add(seconds < 10 ? '0' + seconds : seconds);
    return sb.toString();
  }

  static int parseInt(String str) {
    str = str.replaceFirst('px', '');
    int value = Math.parseInt(str);
    return value;
  }

}
