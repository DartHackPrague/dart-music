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

  DartMusic(IAudioData ad) {
    this._delay = (1000 / FPS).toInt();
    this._audioData = ad;
    
    document.on.resize.add((e) {
      
    });
  }

  void update() {
    var data = this._audioData.getData();
    for (final effect in this._effects) {
      if (effect is IRenderer) {
        effect.render(data);
      }
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

  void addEfect(IRenderer effect) {
    this._effects.add(effect);
  }

  /*
  void registerAudio() {
    //getting source from audio tag
    dom.AudioContext audioContext = new dom.AudioContext();
    var audio = document.query("audio");
    var source = audioContext.createMediaElementSource(audio);
    dom.AudioGainNode volumeNode = audioContext.createGainNode();

    dom.RealtimeAnalyserNode analyser = audioContext.createAnalyser();
    source.connect(analyser, 0, 0);

    
    //window.setInterval(function() {
    //  var arr = new Uint8Array(analyser.frequencyBinCount);
    //  analyser.getByteFrequencyData(arr);
    //  print(arr[500]);
    //  print(arr[800]);
    //}, 500);

    //connecting inputs and outputs
    //source.connect(volumeNode, 0, 0);
    analyser.connect(volumeNode, 0, 0);
    volumeNode.connect(audioContext.destination, 0, 0);

    //volume slider handler
    document.query("#volume").on.change.add((e) {
      var volume = Math.parseInt(e.target.value);
      var max = Math.parseInt(e.target.max);
      var fraction = volume / max;
      volumeNode.gain.value = fraction * fraction;
    });
  }*/
}

void main() {
  Element body = document.query("body");
  BgColorAnimator animator = new BgColorAnimator(body);
  //animator.changeBgColor();
  animator.perpetualColorChange();

  List effects = new List();
  effects.add(new CanvasRenderer(document.query('#drawHere')));
  // ... a dalsi
  
  //IAudioData audioData = new RandomAudioData();
  IAudioData audioData = new MP3AudioData(document.query("#playMe"));
  DragDropHandler dragDrop = new DragDropHandler();
  
  
  DartMusic m = new DartMusic(effects, audioData);
  m.run();
  dragDrop.register();
  
  //m.registerAudio();
  //m.registerDragNDrop();
}
