class CanvasCircle {
  var position;
  var color;
  var opacity;
  var size;
  var minX = 0;
  var minY = 100;
  var maxX;
  var maxY;
  int minSize = 25;
  int maxSize = 60;

  CanvasCircle(Position position, RgbColor color, int maxX, int maxY) {
    this.position = position;
    this.color = color;
    this.opacity = 1;
    this.size = DartMath.Random(minSize, maxSize);
  }

  void move() {
    var newPosition = Position.RandomPosition(minX, maxX, minY, maxY);
    this.position = newPosition;
  }

}
