
class CanvasRenderer implements IRenderer {
  
  static final BOTTOM_OFFSET = 20;
  
  CanvasElement canvas;
  CanvasRenderingContext2D ctx;
  
  CanvasRenderer(CanvasElement elm) {
    this.canvas = elm;
    this.canvas.width = window.innerWidth;
    this.canvas.height = window.innerHeight;

    this.ctx = this.canvas.getContext("2d");
  }
  
  void render(List data) {
    //print('Canvas render');
    //print(data.length);
    
    //this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
    //this.ctx.fillStyle = '#eee';
    //this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
    this.canvas.width = this.canvas.width;
    
    int maxLineHeight = (0.3 * this.canvas.height).toInt();
    int leftPos = ((window.innerWidth - data.length) / 2).toInt();
    
    this.ctx.strokeStyle = '#00f';
    this.ctx.lineWidth = 1;

    int max = 255 * 255;
    for (int i=0; i < data.length; i++) {
      //print(data[i]);
      int height = (data[i] * data[i]) / max * maxLineHeight;
      this.ctx.moveTo(leftPos, this.canvas.height - BOTTOM_OFFSET);
      this.ctx.lineTo(leftPos, this.canvas.height - height - BOTTOM_OFFSET);
      
      leftPos++;
    }
    this.ctx.stroke();
  }
  
}
