#import('dart:html');
#import('dart:dom', prefix:'dom');

#source('IAudioData.dart');
#source('IRenderer.dart');
#source('RandomAudioData.dart');
#source('MP3AudioData.dart');
#source('CanvasRenderer.dart');
#source('BgColorAnimator.dart');
#source('RgbColor.dart');
#source('DragDropHandler.dart');


class DartMusic {

  // canvas redraw rate
  static final FPS = 30;

  int _delay;
  IAudioData _audioData;
  List _effects;

  DartMusic() {
    this._delay = (1000 / FPS).toInt();
    this._effects = new List();
    
    window.on.resize.add((Event e) {
      for (final effect in this._effects) {
        effect.resize();
      }
    });
  }

  void update() {
    var data = this._audioData.getData();
    for (final effect in this._effects) {
      effect.render(data);
    }
  }

  void run() {
    window.setInterval(f() => this.update(), this._delay);
  }


  void registerDragNDrop() {
    document.on.drop.add( function( MouseEvent event ) {
      event.preventDefault();
      event.stopPropagation();
      //obtaining file path
      FileList files = event.dataTransfer.files;
      FileReader reader = new FileReader();
      reader.on.loadStart.add((Event e) { print("load start"); });
      reader.on.progress.add((Event e) { print("progress"); });
      reader.on.error.add((Event e) { print("error"); });

      reader.on.load.add( (Event e) {
        print("file loaded ");
        AudioElement audioOld = document.query("audio");
        
        AudioElement audio = new AudioElement();
        audio.src = e.target.result;
        audio.controls = true;
        audioOld.replaceWith(audio);
        //document.body.nodes.add(audio);
      });
      for(int i = 0; i < files.length; i++) {
        File file = files.item(i);
        print("dragged file: "+file.name);
        reader.readAsDataURL(file);
      }

    });
  }

  void addEffect(IRenderer effect) {
    this._effects.add(effect);
  }
  
  void setAudioSource(IAudioData audio) {
    this._audioData = audio;
  }
  
}

void main() {
  Element body = document.query("body");
  BgColorAnimator animator = new BgColorAnimator(body);
  //animator.perpetualColorChange();
  animator.changeBgColor();
  
  //IAudioData audioData = new RandomAudioData();
  DragDropHandler dragDrop = new DragDropHandler();
  
  
  DartMusic m = new DartMusic();
  m.addEffect(new CanvasRenderer(document.query('#drawHere'), document.query("#playMe")));
  m.setAudioSource(new MP3AudioData(document.query("#playMe")));
  m.run();
  dragDrop.register();
  
  //m.registerAudio();
  //m.registerDragNDrop();
}
