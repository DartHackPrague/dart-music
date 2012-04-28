
class CanvasRenderer implements IRenderer {
  
  static final BOTTOM_OFFSET = 200;
  
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  
  CanvasRenderer(CanvasElement elm) {
    this._canvas = elm;
    this._canvas.width = window.innerWidth;
    this._canvas.height = window.innerHeight;

    this._ctx = this._canvas.getContext("2d");
  }
  
  void render(List data) {
    //print('Canvas render');
    //print(data.length);
    
    //this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
    //this.ctx.fillStyle = '#eee';
    //this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
    this._canvas.width = this._canvas.width;
    
    int maxLineHeight = (0.3 * this._canvas.height).toInt();
    //int leftPos = ((window.innerWidth - data.length) / 2).toInt();
    int leftPos = 0;
    double lineWidth = (this._canvas.width / data.length).ceil();
    this._ctx.strokeStyle = '#eee';
    this._ctx.lineWidth = lineWidth;

    int max = 255 * 255;
    for (int i=0; i < data.length; i++) {
      int height = (data[i] * data[i]) / max * maxLineHeight;
      this._ctx.moveTo(leftPos, this._canvas.height - BOTTOM_OFFSET + height / 2);
      this._ctx.lineTo(leftPos, this._canvas.height - height / 2 - BOTTOM_OFFSET);
      
      leftPos += lineWidth;
    }
    this._ctx.stroke();
  }
  
}
