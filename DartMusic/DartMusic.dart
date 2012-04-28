#import('dart:html');
#source('IAudioData.dart');
#source('RandomAudioData.dart');
#source('IRenderer.dart');
#source('CanvasRenderer.dart');


class DartMusic {

  int fps = 5;
  int delay;
  IRenderer renderer;
  
  DartMusic(IRenderer rend) {
    this.delay = (1000 / this.fps).toInt();
    this.renderer = rend;
  }

  void update() {
    print("Hello World!");
    
  }
  
  void run() {
    window.setInterval(f() => this.update(), this.delay);
  }
  
}

void main() {
  CanvasElement canvas = document.query('#drawHere');
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  new DartMusic(new CanvasRenderer(canvas)).run();
}
