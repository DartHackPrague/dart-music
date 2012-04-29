class EasterEgg {

  CanvasElement _canvas = null;
  CanvasRenderingContext2D _ctx;
  int top = 100;
  int left = 100;

  String pathToImage = "images/dart_logo.png";

  void Surprise() {
    if (_canvas == null) {
      _canvas = document.query("#easterEgg");
      _ctx = this._canvas.getContext("2d");

      _canvas.style.position = "absolute";
      _canvas.style.top = top.toString() + 'px';
      _canvas.style.left = left.toString() + 'px';
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
    _canvas.style.position = "absolute";
    _canvas.style.top = '400px';
    _canvas.style.left = '600px';
  }

}
