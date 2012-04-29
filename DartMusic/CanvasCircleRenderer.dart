class CanvasCircleRenderer implements IRenderer {

  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  int _bottomOffset;
  int _drawDragDropStartLine = -1;
  List<CanvasCircle> circles;

  int minCirclesCount = 1;
  int maxCirclesCount = 5;
  static final PI2 = Math.PI * 2;

  CanvasCircleRenderer(CanvasElement elm) {
    _canvas = elm;
    _ctx = this._canvas.getContext("2d");

    resize();

    this.circles = _createCircles();
  }

  void render(List data, int time) {
    _renderCircles(this.circles);
  }

  void resize() {
    this._canvas.width = window.innerWidth;
    this._canvas.height = window.innerHeight;
    this._bottomOffset = (this._canvas.height / 3).toInt();
  }


  List<CanvasCircle> _createCircles() {
    var _circles = new List<CanvasCircle>();

    var count = _getRandom(minCirclesCount, maxCirclesCount);
    for(var i=0; i<count; i++) {
      var position = new Position(i*20, i*40);
      var color = _getRandomColor(0, 255);
      var circle = new CanvasCircle(position, color);
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
    _renderCircle(circle, _ctx);
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

  int _getRandom(int min, int max) {
    var randVal = min + (Math.random()*(max - min));
    var result = Math.parseDouble(randVal.toString()); //Because there is no floor() or round() method in Math
    return result;
  }

  int _getRandomColor(int min, int max) {
    var r = _getRandom(min, max);
    var g = _getRandom(min, max);
    var b = _getRandom(min, max);
    var color = new RgbColor(r, g, b);
    return color;
  }

  /**
   * required by the interface definition
   */
  void setAudioElement(AudioElement audio) {  }

  
}