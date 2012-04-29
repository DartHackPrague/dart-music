class CanvasCircleRenderer implements IRenderer {

  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  int _bottomOffset;
  int _drawDragDropStartLine = -1;
  List<CanvasCircle> circles;

  int minCirclesCount = 1;
  int maxCirclesCount = 5;

  CanvasCircleRenderer(CanvasElement elm) {
    _canvas = elm;
    _ctx = this._canvas.getContext("2d");

    resize();

    circles = createCircles();
  }

  void render(List data) {
    print('rendered ');
  }

  void resize() {
    this._canvas.width = window.innerWidth;
    this._canvas.height = window.innerHeight;
    this._bottomOffset = (this._canvas.height / 3).toInt();
  }

  List<CanvasCircle> createCircles() {
    if (circles == null) {
      circles = new List<CanvasCircle>();
    }

    var count = getRandom(minCirclesCount, maxCirclesCount);
    for(var i=0; i<count; i++) {
      var position = new Position(i*20, i*40);
      var color = getRandomColor(0, 255);
      var circle = new CanvasCircle(position, color);
      circles.add(circle);
    }

    print(circles.length);
  }

  int getRandom(int min, int max) {
    var randVal = min + (Math.random()*(max - min));
    var result = Math.parseDouble(randVal.toString()); //Because there is no floor() or round() method in Math
    return result;
  }

  int getRandomColor(int min, int max) {
    var r = getRandom(min, max);
    var g = getRandom(min, max);
    var b = getRandom(min, max);
    var color = new RgbColor(r, g, b);
    return color;
  }

}