
class CanvasRenderer implements IRenderer {
  
  //static final BOTTOM_OFFSET = 200;
  
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  AudioElement _audio;
  int _bottomOffset;
  int _drawDragDropStartLine = -1;
  
  CanvasRenderer(CanvasElement elm, AudioElement audio) {
    this._canvas = elm;
    this._audio = audio;
    this._ctx = this._canvas.getContext("2d");
    this.resize();
    
    this._canvas.on.mouseMove.add((MouseEvent e) {
      // mouse cursor is under the 1/3 of the page
      if (e.pageY > this._canvas.height * 0.3) {
        this._drawDragDropStartLine = e.pageX;
      } else {
        this._drawDragDropStartLine = -1;
      }
    });
  }
  
  void render(List data) {
    this._canvas.width = this._canvas.width;
    
    int maxLineHeight = (0.3 * this._canvas.height).toInt();
    //int leftPos = ((window.innerWidth - data.length) / 2).toInt();
    int leftPos = 0;
    double step = this._canvas.width / data.length;
    int lineWidth = step.ceil().toInt();
    int basePosition = this._canvas.height - this._bottomOffset;
    
    //this._ctx.strokeStyle = '#eee';
    
    this._ctx.beginPath();
    this._ctx.strokeStyle = "rgba(255,255,255,0.2)";
    this._ctx.lineWidth = 1;
    this._ctx.moveTo(0, this._canvas.height - this._bottomOffset);
    this._ctx.lineTo(this._canvas.width, this._canvas.height - this._bottomOffset);
    this._ctx.closePath();
    this._ctx.stroke();
    
    /**
     * "mirror like" reflection
     */
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
      this._ctx.moveTo(leftPos, basePosition + height / 2);
      this._ctx.lineTo(leftPos, basePosition - height / 2);
      
      leftPos += step;
    }
    this._ctx.closePath();
    this._ctx.stroke();
    
    /**
     * draw "progress bar"
     */
    this._ctx.beginPath();
    leftPos = ((this._audio.currentTime / this._audio.duration) * this._canvas.width).round().toInt();
    int height = data[((this._audio.currentTime / this._audio.duration) * data.length).round().toInt()];
    if (height < 30) {
      height = 30;
    }
    // copy mirror like reflection from above
    cg = this._ctx.createLinearGradient(0, basePosition - maxLineHeight,
                                        0, basePosition + maxLineHeight);
    cg.addColorStop(0, "#bbb");
    cg.addColorStop(0.5, "#bbb");
    cg.addColorStop(0.5, "rgba(210,210,210,0.6)");
    cg.addColorStop(0.65, "rgba(210,210,210,0.3)");
    cg.addColorStop(1, "rgba(210,210,210,0.05)");
    this._ctx.strokeStyle = cg;
    this._ctx.lineWidth = 2;
    // line
    this._ctx.moveTo(leftPos, basePosition + height / 2);
    this._ctx.lineTo(leftPos, basePosition - height / 2);
    // little arrows
    this._ctx.moveTo(leftPos - 3, basePosition + height / 2);
    this._ctx.lineTo(leftPos + 3, basePosition + height / 2);
    this._ctx.moveTo(leftPos - 3, basePosition - height / 2);
    this._ctx.lineTo(leftPos + 3, basePosition - height / 2);

    this._ctx.closePath();
    this._ctx.stroke();
    
    /**
     * draw drag & drop selection line
     */
    if (this._drawDragDropStartLine != -1) {
      this._ctx.beginPath();
      this._ctx.strokeStyle = "rgba(255,255,255,0.25)";
      this._ctx.lineWidth = 7;
      this._ctx.moveTo(this._drawDragDropStartLine, basePosition + maxLineHeight * 0.8);
      this._ctx.lineTo(this._drawDragDropStartLine, basePosition - maxLineHeight * 0.8);
      this._ctx.closePath();
      this._ctx.stroke();
    }
  }
  
  void resize() {
    this._canvas.width = window.innerWidth;
    this._canvas.height = window.innerHeight;
    this._bottomOffset = (this._canvas.height / 3).toInt();
  }
}
