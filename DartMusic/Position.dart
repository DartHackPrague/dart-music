class Position {
  int x;
  int y;

  Position(x, y) {
    this.x = x;
    this.y = y;
  }

  static Position RandomPosition(int minX, int maxX, int minY, int maxY) {
    var x = DartMath.Random(minX, maxX);
    var y = DartMath.Random(minY, maxY);
    var position = new Position(x, y);
    return position;
  }
}
