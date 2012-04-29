class DartMath {

  static int Random(int min, int max) {
    int value = (min + (Math.random() * (max - min))).round();
    return value;
  }

  static int Average(List<int> numbers) {
    if (numbers.length == 0) return 0;

    var len = numbers.length;
    var total = 0;
    var result = 0;
    numbers.forEach(f(number) => total += number);
    result = total / len;
    return result;
  }

}
