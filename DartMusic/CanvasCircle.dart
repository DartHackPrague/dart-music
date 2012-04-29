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

  int stepUp = 2;
  int stepAside = 3;


  CanvasCircle(Position position, RgbColor color, int maxX, int maxY) {
    this.position = position;
    this.color = color;
    this.opacity = 1;
    this.size = DartMath.Random(minSize, maxSize);
    this.oldSize = this.size;
    this.maxX = maxX;
    this.maxY = maxY;
  }

  bool getRandomDirection() {
    var i = DartMath.Random(0, 2);
    bool gotoLeft;
    if (i > 1) {
      gotoLeft = true;
    }
    else {
      gotoLeft = false;
    }
    return gotoLeft;
  }

  void moveRandom() {
    var newPosition = Position.RandomPosition(this.minX, this.maxX, this.minY, this.maxY);
    this.position = newPosition;
  }

  void moveAside() {
    var x = this.position.x;
    var y = this.position.y;
    var gotoLeft = getRandomDirection();
    if (gotoLeft) {
      y += stepAside;
    }
    else {
      y -= stepAside;
    }

    var newPosition = new Position(x, y);
    this.position = newPosition;
  }

  void moveUp() {
    var x = this.position.x - stepUp;
    var y = this.position.y;

    var newPosition = new Position(x, y);
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
