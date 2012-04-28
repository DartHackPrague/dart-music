#import('dart:html');
#import('dart:dom', prefix:'dom');

#source('IAudioData.dart');
#source('IRenderer.dart');
#source('RandomAudioData.dart');
#source('MP3AudioData.dart');
#source('CanvasRenderer.dart');


class DartMusic {

  // canvas redraw rate
  static final FPS = 15;
  
  int delay;
  IRenderer renderer;
  IAudioData audioData;
  
  DartMusic(IRenderer rend, IAudioData ad) {
    this.delay = (1000 / FPS).toInt();
    this.renderer = rend;
    this.audioData = ad;
  }

  void update() {
    this.renderer.render(this.audioData.getData());
  }

  void run() {
    window.setInterval(f() => this.update(), this.delay);
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
        var audio = document.query("audio");
        audio.src = e.target.result;
      });
      for(int i = 0; i < files.length; i++) {
        File file = files.item(i);
        
//        print("FileReader.DONE="+FileReader.DONE);
//        print("FileReader.EMPTY="+FileReader.EMPTY);
//        print("FileReader.LOADING="+FileReader.LOADING);
        print("dragged file: "+file.name);
        reader.readAsDataURL(file);
      }
      
    });
  }



  void registerAudio() {
    //getting source from audio tag
    dom.AudioContext audioContext = new dom.AudioContext();
    var audio = document.query("audio");
    var source = audioContext.createMediaElementSource(audio);
    dom.AudioGainNode volumeNode = audioContext.createGainNode();

    dom.RealtimeAnalyserNode analyser = audioContext.createAnalyser();
    source.connect(analyser, 0, 0);

    /*
    window.setInterval(function() {
      var arr = new Uint8Array(analyser.frequencyBinCount);
      analyser.getByteFrequencyData(arr);
      print(arr[500]);
      print(arr[800]);
    }, 500);
    */

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
  }
}

void main() {
  //IAudioData audioData = new RandomAudioData();
  IAudioData audioData = new MP3AudioData(document.query("#playMe"));
  IRenderer renderer = new CanvasRenderer(document.query('#drawHere'));
  
  DartMusic m = new DartMusic(renderer, audioData);
  m.run();
  //m.registerAudio();
  m.registerDragNDrop();
}
