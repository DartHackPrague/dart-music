
class CanvasRenderer implements IRenderer {

  //static final BOTTOM_OFFSET = 200;

  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  AudioElement _audio;
  IAudioData _audioSource;
  
  int _bottomOffset;
  bool _dragDropActive = false;
  int _canvasMouseXPos;
  int _drawDragDropSelectionBegin = -1, _drawDragDropSelectionEnd = -1;
  int _drawDragDropSelectionEndOld, _drawDragDropSelectionBeginOld;
  var _onSelectionChangeCallback;
  //Map _gradients;
  
  CanvasRenderer(CanvasElement elm, AudioElement audio) {
    this._canvas = elm;
    this._audio = audio; // only to draw the progress bar
    this._ctx = this._canvas.getContext("2d");
    //this._ctx.save(); // save default settings
    this.resize();

    this._canvas.on.mouseMove.add((MouseEvent e) {
      // mouse cursor is under the 1/3 of the page
      if (e.pageY > this._canvas.height * 0.25) {
        if (this._dragDropActive) {
          this._drawDragDropSelectionEnd = e.pageX;
        } else {
          this._canvasMouseXPos = e.pageX;
        }
      } else {
        this._canvasMouseXPos = -1;
      }
    });
    
    this._canvas.on.mouseDown.add((MouseEvent e) {
      if (e.pageY > this._canvas.height * 0.25) {
        this._dragDropActive = true;
        this._drawDragDropSelectionEndOld = this._drawDragDropSelectionEnd;
        this._drawDragDropSelectionBeginOld = this._drawDragDropSelectionBegin;
        
        this._drawDragDropSelectionBegin = e.pageX;
        this._drawDragDropSelectionEnd = e.pageX;
      }
    });
    
    this._canvas.on.mouseUp.add((MouseEvent e) {
      if (this._dragDropActive) {
        if (this._drawDragDropSelectionBegin == this._drawDragDropSelectionEnd) {
          this._drawDragDropSelectionEnd = this._drawDragDropSelectionEndOld;
          this._drawDragDropSelectionBegin = this._drawDragDropSelectionBeginOld;
          // jump to the specified position
          this._audio.currentTime = (e.pageX / this._canvas.width) * this._audio.duration;
          this._audio.play();
        } else {
          this._drawDragDropSelectionEnd = e.pageX;
          this._canvasMouseXPos = e.pageX;
          this._onSelectionChangeCallback(this.getSelection());
        }
        this._dragDropActive = false;
      }
    });
    
    window.on.keyPress.add((KeyboardEvent e) {
      if (e.keyCode == 32) {
        this._drawDragDropSelectionEnd = -1;
        this._drawDragDropSelectionBegin = -1;
        this._onSelectionChangeCallback([0, 1]);
        e.preventDefault();
      }
    });
    
    //this._gradients = new Map();
    //this._gradients['selection'] = 
    
  }
  
  void render(List data, int time) {
    // clear canvas
    this._canvas.width = this._canvas.width;
    CanvasGradient cg;
    
    // maximum height that any line in the analyzer can have 

    int maxLineHeight = (0.6 * this._canvas.height).toInt();
    /*if (maxLineHeight * 2 > this._canvas.height * 0.8) {
      maxLineHeight = (this._canvas.height / 3).toInt();
    }*/
    
    int leftPos = 0;
    // step size for x axis
    double step = this._canvas.width / data.length;
    // width of every single line in frequency analyzer
    int lineWidth = step.ceil().toInt();
    // start y position (middle of the frequency analyzer)
    int basePosition = this._canvas.height - this._bottomOffset;

    /**
     * splitting line
     */
    //this._ctx.beginPath();
    this._ctx.lineWidth = 1;
    this._ctx.strokeStyle = "rgba(0,0,0,0.1)";
    this._ctx.moveTo(0, basePosition);
    this._ctx.lineTo(this._canvas.width, basePosition);
    this._ctx.stroke();
    //this._ctx.closePath();

    /**
     * "mirror like" reflection
     */
    cg = this._ctx.createLinearGradient(0, this._canvas.height - this._bottomOffset - maxLineHeight / 2,
                                        0, this._canvas.height - this._bottomOffset + maxLineHeight / 2);
    cg.addColorStop(0, "#d00");
    cg.addColorStop(0.2, "#000");
    cg.addColorStop(0.5, "#000");
    cg.addColorStop(0.5, "rgba(0,0,0,0.8)");
    //cg.addColorStop(0.65, "rgba(0,0,0,0.8)");
    cg.addColorStop(0.8, "rgba(0,0,0, 0.6)");
    cg.addColorStop(1, "rgba(221,0,0,0.3)");

    this._ctx.beginPath();
    //this._ctx.strokeStyle = cg;
    this._ctx.lineWidth = lineWidth;
    this._ctx.strokeStyle = cg;

    // power of 2 - just to make bigger differences between low and high values (looks better)
    //int max = (this._canvas.height * this._canvas.height / 6).toInt();
    int max = 255 * 255;
    for (int i=0; i < data.length; i++) {
      if (data[i] > 1) {
        int height = ((data[i] * data[i]) / max) * maxLineHeight;
        this._ctx.moveTo(leftPos, basePosition + height / 2);
        this._ctx.lineTo(leftPos, basePosition - height / 2);
      }
      leftPos += step;
    }
    
    this._ctx.stroke();

    /**
     * draw slider
     */
    // draw slider only if audio is preloaded enought
    if (this._audio.readyState == MediaElement.HAVE_ENOUGH_DATA && !this._audio.ended && this._audio.duration > 0) {
      this._ctx.beginPath();
      leftPos = ((this._audio.currentTime / this._audio.duration) * this._canvas.width).floor().toInt();
      int index = ((this._audio.currentTime / this._audio.duration) * (data.length - 1)).floor().toInt();
      /*if (index > 1023) {
        print(index);
        index = 1023;
      }*/
      int height = (data[index] / 255) * maxLineHeight * 1.1;
      if (height < 100) {
        height = 100;
      }
      // copy slider mirror like reflection from above
      cg = this._ctx.createLinearGradient(0, basePosition - maxLineHeight,
                                          0, basePosition + maxLineHeight);
      cg.addColorStop(0, "#999");
      cg.addColorStop(0.5, "#999");
      cg.addColorStop(0.5, "rgba(160,160,160,0.6)");
      cg.addColorStop(0.65, "rgba(160,160,160,0.3)");
      cg.addColorStop(1, "rgba(160,160,160,0.05)");
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
  
      //this._ctx.closePath();
      this._ctx.stroke();
      
      // processed / total time
      this._ctx.beginPath();
      // add textual description
      this._ctx.font = "bold 12px tahoma";
      this._ctx.fillStyle = "#888";
      //this._ctx.shadowBlur  = 2;
      //this._ctx.shadowColor = '#888';
            
      String textTotal = DartMath.getNiceTime(this._audio.duration);
      this._ctx.fillText(textTotal, this._canvas.width - 32, basePosition - 8);
      //this._ctx.fill();
      
      String textProgress = DartMath.getNiceTime(this._audio.currentTime);
      this._ctx.fillText(textProgress, leftPos - 33, basePosition + 15);
      //this._ctx.fill();
      
      //this._ctx.strokeText(text, leftPos + 4, basePosition - 5);

      //this._ctx.closePath();
      this._ctx.fill();
      
      this._ctx.shadowBlur = 0;
      //this._ctx.stroke();
    }
    

    /**
     * draw drag & drop selected area
     */
    cg = this._ctx.createLinearGradient(0, basePosition - maxLineHeight * 0.8,
                                        0, basePosition + maxLineHeight * 0.8);
    cg.addColorStop(0, "rgba(255,219,59,0.05)");
    cg.addColorStop(0.25, "rgba(255,219,59,0.25)");
    cg.addColorStop(0.75, "rgba(255,219,59,0.25)");
    cg.addColorStop(1, "rgba(255,219,59,0.05)");
    
    this._ctx.fillStyle = cg;

    if (this._drawDragDropSelectionBegin != -1 && this._drawDragDropSelectionEnd != -1) {
      this._ctx.beginPath();
      int rectWidth = (this._drawDragDropSelectionEnd - this._drawDragDropSelectionBegin).abs();
      int rectX = this._drawDragDropSelectionEnd < this._drawDragDropSelectionBegin ? this._drawDragDropSelectionEnd : this._drawDragDropSelectionBegin;
      int rectY = basePosition - maxLineHeight * 0.5;
      int rectHeight = maxLineHeight * 0.5 * 2;
      this._ctx.lineWidth = 1;
      this._ctx.strokeStyle = "rgba(255,210,23,0.5)";
      this._ctx.rect(rectX, rectY, rectWidth, rectHeight);
      this._ctx.fill();
      //this._ctx.lineTo(this._drawDragDropStartLine, basePosition - maxLineHeight * 0.8);
      //this._ctx.closePath();
      this._ctx.stroke();
    }
    
    /**
     * draw drag & drop guide line
     */ 
    if (!this._dragDropActive && this._canvasMouseXPos != -1) {
      this._ctx.beginPath();
      this._ctx.lineWidth = 6;
      this._ctx.strokeStyle = cg;
      this._ctx.moveTo(this._canvasMouseXPos, basePosition - maxLineHeight * 0.5);
      this._ctx.lineTo(this._canvasMouseXPos, basePosition + maxLineHeight * 0.5);
      //this._ctx.closePath();
      this._ctx.stroke();
    }
    
    /**
     * render song title
     */
    if (!this._audioSource.getTitle().isEmpty()) {
      TextMetrics metrics = this._ctx.measureText(this._audioSource.getTitle());
      this._ctx.fillStyle = "#888";
      this._ctx.fillText(this._audioSource.getTitle(), this._canvas.width - metrics.width - 10, this._canvas.height - 10);
    }
    
    //this._ctx.restore();
    //this._ctx.save();
  }

  void resize() {
    this._canvas.width = window.innerWidth;
    this._canvas.height = window.innerHeight;
    this._bottomOffset = (this._canvas.height / 2.5).toInt();
  }
  
  void setAudioElement(IAudioData audio) {
    this._audioSource = audio;
    this._audio = audio.getElement();
  }
  
  List getSelection() {
    double val1 = this._drawDragDropSelectionBegin == -1 ? 0 : this._drawDragDropSelectionBegin.abs() / this._canvas.width;
    double val2 = this._drawDragDropSelectionEnd == -1 ? 0 : this._drawDragDropSelectionEnd.abs() / this._canvas.width;
    
    return val1 < val2 ? [ val1, val2 ] : [ val2, val1 ];
  }
  
  void onSelectionChanged(callback) {
    this._onSelectionChangeCallback = callback;
  }
  
  /*
  void onSelectionChanged(IAudioData ad) {
    List sel = this.getSelection();
    ad.setMinFreq(sel[0]);
    ad.setMaxFreq(sel[1]);
  }
  */
}
