class CanvasCircle {
  var position;
  var color;
  var opacity;
  var size;
  var oldSize;
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
    this.oldSize = this.size;
    this.maxX = maxX;
    this.maxY = maxY;
  }

  void move() {
    var newPosition = Position.RandomPosition(this.minX, this.maxX, this.minY, this.maxY);
    this.position = newPosition;
  }

  void resize(double factor) {
    if (factor == 1 || factor == null) {
      this.size = this.oldSize;
    }
    else {
      this.size = this.oldSize * factor;
    }
  }

}
