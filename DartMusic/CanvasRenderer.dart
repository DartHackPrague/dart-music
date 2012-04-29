
class CanvasRenderer implements IRenderer {
  
  //static final BOTTOM_OFFSET = 200;
  
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  AudioElement _audio;
  int _bottomOffset;
  
  CanvasRenderer(CanvasElement elm, AudioElement audio) {
    this._canvas = elm;
    this._audio = audio;
    this._ctx = this._canvas.getContext("2d");
    this.resize();
  }
  
  void render(List data) {
    //print(this._audio.currentTime);    
    //print(this._audio.duration);    

    this._canvas.width = this._canvas.width;
    
    int maxLineHeight = (0.3 * this._canvas.height).toInt();
    //int leftPos = ((window.innerWidth - data.length) / 2).toInt();
    int leftPos = 0;
    double step = this._canvas.width / data.length;
    int lineWidth = step.ceil().toInt();
    
    //this._ctx.strokeStyle = '#eee';
    
    // reflection
    CanvasGradient cg = this._ctx.createLinearGradient(0, this._canvas.height - this._bottomOffset - maxLineHeight / 2,
                                                       0, this._canvas.height - this._bottomOffset + maxLineHeight / 2);
    cg.addColorStop(0, "#eee");
    cg.addColorStop(0.5, "#eee");
    cg.addColorStop(0.5, "rgba(238,238,238,0.9)");
    cg.addColorStop(0.65, "rgba(238,238,238,0.5)");
    cg.addColorStop(1, "rgba(238,238,238,0.05)");
    this._ctx.beginPath();
    this._ctx.strokeStyle = cg;
    this._ctx.lineWidth = lineWidth;

    int max = (this._canvas.height * this._canvas.height / 12).toInt();
    for (int i=0; i < data.length; i++) {
      int height = (data[i] * data[i]) / max * maxLineHeight;
      this._ctx.moveTo(leftPos, this._canvas.height - this._bottomOffset + height / 2);
      this._ctx.lineTo(leftPos, this._canvas.height - this._bottomOffset - height / 2);
      
      leftPos += step;
    }
    this._ctx.closePath();
    this._ctx.stroke();
    
    this._ctx.beginPath();
    // draw "progress bar"
    leftPos = ((this._audio.currentTime / this._audio.duration) * this._canvas.width).round().toInt();
    int height = data[((this._audio.currentTime / this._audio.duration) * data.length).round().toInt()];
    if (height < 30) {
      height = 30;
    }
    cg = this._ctx.createLinearGradient(0, this._canvas.height - this._bottomOffset - maxLineHeight / 2,
                                                       0, this._canvas.height - this._bottomOffset + maxLineHeight / 2);
    cg.addColorStop(0, "#bbb");
    cg.addColorStop(0.5, "#bbb");
    cg.addColorStop(0.5, "rgba(190,190,190,0.6)");
    cg.addColorStop(0.65, "rgba(190,190,190,0.3)");
    cg.addColorStop(1, "rgba(190,190,190,0.05)");
    this._ctx.strokeStyle = cg;
    this._ctx.lineWidth = 2;
    this._ctx.moveTo(leftPos, this._canvas.height - this._bottomOffset + height / 2);
    this._ctx.lineTo(leftPos, this._canvas.height - this._bottomOffset - height / 2);
    this._ctx.closePath();
    this._ctx.stroke();
    print(height);
  }
  
  void resize() {
    this._canvas.width = window.innerWidth;
    this._canvas.height = window.innerHeight;
    this._bottomOffset = (this._canvas.height / 3).toInt();
  }
}
