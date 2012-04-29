class EasterEgg {

  CanvasElement _canvas = null;
  CanvasRenderingContext2D _ctx;
  int top = 100;
  int left = 100;
  int minX = 0;
  int maxX = 0;
  int minY = 0;
  int maxY = 0;

  int minSpeed = 2; //px
  int maxSpeed = 10;

  String pathToImage = "images/dart_logo.png";


  void Surprise() {
    if (_canvas == null) {
      _canvas = document.query("#easterEgg");
      _ctx = this._canvas.getContext("2d");

      _canvas.style.position = "absolute";
      _canvas.style.top = top.toString() + 'px';
      _canvas.style.left = left.toString() + 'px';

      maxX = window.innerWidth;
      maxY = window.innerHeight;
    }

    _LoadImage();

    _DoCrazyMovements();
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

    _canvas.style.top = (currentX + minSpeed).toString() + 'px';
    _canvas.style.left = (currentX + minSpeed).toString() + 'px';
  }

}
