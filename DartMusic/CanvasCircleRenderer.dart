class CanvasCircleRenderer implements IRenderer {

  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  int _bottomOffset;
  int _drawDragDropStartLine = -1;

  CanvasCircleRenderer(CanvasElement elm) {
    _canvas = elm;
    _ctx = this._canvas.getContext("2d");

    resize();
  }

  void render(List data) {
    print('rendered ');
  }

  void resize() {
    this._canvas.width = window.innerWidth;
    this._canvas.height = window.innerHeight;
    this._bottomOffset = (this._canvas.height / 3).toInt();
  }

}