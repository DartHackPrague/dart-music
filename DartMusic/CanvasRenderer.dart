
class CanvasRenderer implements IRenderer {
  
  CanvasElement canvas;
  CanvasRenderingContext2D ctx;
  
  CanvasRenderer(CanvasElement elm) {
    this.canvas = elm;
    this.canvas.width = window.innerWidth;
    this.canvas.height = window.innerHeight;

    this.ctx = this.canvas.getContext("2d");
  }
  
  void render(List data) {
    print('Canvas render');
    print(data);
    
    //this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
    this.ctx.fillStyle = '#EEE';
    this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
    
    int maxLineHeight = (0.3 * this.canvas.height).toInt();
    int startPosLeft = ((window.innerWidth - maxLineHeight) / 2).toInt();
    
    double coef = 100 / 255;
    for (final value in data) {
      int height = value * coef * maxLineHeight;
      
    }
  }
  
}
