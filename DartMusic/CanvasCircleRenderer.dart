class CanvasCircleRenderer implements IRenderer {

  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  int _bottomOffset;
  int _drawDragDropStartLine = -1;
  List<CanvasCircle> circles;

  int minCirclesCount = 4;
  int maxCirclesCount = 15;
  static final PI2 = Math.PI * 2;

  CanvasCircleRenderer(CanvasElement elm) {
    _canvas = elm;
    _ctx = this._canvas.getContext("2d");

    resize();

    this.circles = _createCircles();
  }

  void render(List data, int time) {
    // clear canvas
    //this._canvas.width = this._canvas.width;

    _renderCircles(this.circles);
  }

  void resize() {
    this._canvas.width = window.innerWidth;
    this._canvas.height = window.innerHeight;
    this._bottomOffset = (this._canvas.height / 3).toInt();
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


  void _renderCircles(List<CanvasCircle> circles) {
    circles.forEach(f(circle) => _manageCircle(circle));
  }

  //Kill circle if it should be dead
  //renders on position
  void _manageCircle(CanvasCircle circle) {
    if (circle.opacity > 0) {
      _renderCircle(circle, _ctx);
      circle.move();
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