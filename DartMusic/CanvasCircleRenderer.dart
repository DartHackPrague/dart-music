class CanvasCircleRenderer implements IRenderer {

  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  int _bottomOffset;
  int _drawDragDropStartLine = -1;
  List<CanvasCircle> circles;

  int minCirclesCount = 8;
  int maxCirclesCount = 25;

  static final PI2 = Math.PI * 2;
  static final volumeMax = 255;
  static final volumeOptimum = 127;

  int counter = 0;
  int limitToRender = 3; //smaller number means MORE OFTEN

  CanvasCircleRenderer(CanvasElement elm) {
    _canvas = elm;
    _ctx = this._canvas.getContext("2d");

    resize();

    this.circles = _createCircles();
  }

  void render(List data, int time) {
    if (counter >= limitToRender) {
      clearCanvas();
      _renderCircles(data);
      counter = 0;
    }
    else {
      counter++;
    }
  }

  void clearCanvas() {
    this._canvas.width = this._canvas.width;
  }

  void resize() {
    this._canvas.width = window.innerWidth;
    this._canvas.height = window.innerHeight;
    this._bottomOffset = (this._canvas.height / 3).toInt();

    this.circles = _createCircles();
    _renderCircles(null);
  }


  List<CanvasCircle> _createCircles() {
    var _circles = new List<CanvasCircle>();

    var count = DartMath.Random(minCirclesCount, maxCirclesCount);
    for(var i=0; i<count; i++) {
      var position = Position.RandomPosition(0, this._canvas.width, 0, this._canvas.height);
      var color = _getRandomColor(0, 255);
      var circle = new CanvasCircle(position, color, this._canvas.width, this._canvas.height);
      _circles.add(circle);
    }

    return _circles;
  }

  void _renderCircles(List data) {
    if (data != null && data.length > 0) {
      var factor = getResizeFactor(data);
      this.circles.forEach(f(circle) => _manageCircle(circle, factor));
    }
    else {
      double fixedFactor = 1/1;
      this.circles.forEach(f(circle) => _manageCircle(circle, fixedFactor));
    }

  }

  double getResizeFactor(data) {
    var avg = DartMath.Average(data);
    var factor = avg / volumeOptimum;
    return factor;
  }

  //TODO Kill circle if it should be dead
  //renders on position
  void _manageCircle(CanvasCircle circle, double resizeFactor) {
    if (circle.opacity > 0) {

      circle.resize(resizeFactor);

      //circle.moveRandom();
      circle.moveUp();
      circle.moveAside();


      _renderCircle(circle, _ctx);

    }
    else {
      _killCircle(circle, _ctx);
    }
  }

  void _renderCircle(CanvasCircle circle, CanvasRenderingContext2D ctx) {
    ctx.beginPath();
    ctx.setLineWidth(2);
    ctx.setFillColor(circle.color.toString());
    ctx.setStrokeColor(circle.color.toString());
    ctx.arc(circle.position.x, circle.position.y, circle.size, 0, PI2, false);
    ctx.fill();
    ctx.closePath();
    ctx.stroke();
  }

  void _killCircle(CanvasCircle circle, CanvasRenderingContext2D ctx) {
    print('This circle should be killed now');
  }

  int _getRandomColor(int min, int max) {
    var r = DartMath.Random(min, max);
    var g = DartMath.Random(min, max);
    var b = DartMath.Random(min, max);
    var color = new RgbColor(r, g, b);
    return color;
  }

  /**
   * required by the interface definition
   */
  void setAudioElement(AudioElement audio) {  }


}