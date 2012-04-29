class Position {
  int x;
  int y;

  Position(x, y) {
    this.x = x;
    this.y = y;
  }

  static Position RandomPosition(int minX, int maxX, int minY, int maxY) {
    var x = _getRandom(minX, maxX);
    var y = _getRandom(minY, maxY);
    var position = new Position(x, y);
    return position;
  }

  static int _getRandom(int min, int max) {
    var randVal = min + (Math.random()*(max - min));
    var result = Math.parseDouble(randVal.toString()); //Because there is no floor() or round() method in Math
    return result;
  }

}
