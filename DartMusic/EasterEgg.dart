class EasterEgg {

  CanvasElement _canvas = null;
  CanvasRenderingContext2D _ctx;
  int top = 100;
  int left = 100;
  int minX = 0;
  int maxX = 0;
  int minY = 0;
  int maxY = 0;
  int width = 190;
  int height = 190;

  int minSpeed = 2; //px
  int maxSpeed = 10;
  int limit = 20;
  int interval = 50;

  bool goLeft = false;
  bool goDown = true;
  var animation = null;

  String pathToImage = "images/dart_logo.png";


  void Surprise() {
    if (animation != null) {
      animation = null;
      _canvas.style.display = "none";
      return;
    }

    if (_canvas == null) {
      _canvas = document.query("#easterEgg");
      _ctx = this._canvas.getContext("2d");

      _canvas.style.position = "absolute";
      _canvas.style.top = top.toString() + 'px';
      _canvas.style.left = left.toString() + 'px';

      maxX = window.innerWidth - width;
      maxY = window.innerHeight - height;
    }

    _canvas.style.display = "block";

    _LoadImage();

    animation = window.setInterval(_DoCrazyMovements,interval);

  }

  void _LoadImage() {
    var myImage = new Element.tag("img");
    myImage.on.load.add((_) {
      _ctx.drawImage(myImage, 0, 0);
    });

    myImage.src = pathToImage;
  }

  void _DoCrazyMovements() {
    //move canvas arround

    var currentX = DartMath.parseInt( _canvas.style.left );
    var currentY = DartMath.parseInt( _canvas.style.top );

    if (currentX > maxX) {
      goLeft = true;
    }
    else {
      goLeft = false;
    }

    if (currentY >= maxY) {
      goDown = false;
    }
    else {
      goDown = true;
    }

    _canvas.style.top = (goLeft ? currentX - minSpeed : currentX + minSpeed).toString() + 'px';
    _canvas.style.left = (goDown ? currentY + minSpeed : currentY - minSpeed).toString() + 'px';
  }

}
