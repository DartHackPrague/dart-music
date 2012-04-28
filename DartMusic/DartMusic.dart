#import('dart:html');
#import('dart:dom', prefix:'dom');

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

  void registerAudio() {
    //getting source from audio tag
    dom.AudioContext audioContext = new dom.AudioContext();
    var audio = document.query("audio");
    var source = audioContext.createMediaElementSource(audio);
    dom.AudioGainNode volumeNode = audioContext.createGainNode();

    dom.RealtimeAnalyserNode analyser = audioContext.createAnalyser();
    source.connect(analyser, 0, 0);

    print(analyser.frequencyBinCount);

    window.setInterval(function() {
      var arr = new Uint8Array(analyser.frequencyBinCount);
      analyser.getByteFrequencyData(arr);
      print(arr[500]);
      print(arr[800]);
    }, 500);

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
  CanvasElement canvas = document.query('#drawHere');
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;

  DartMusic m = new DartMusic(new CanvasRenderer(canvas));
  m.run();
  m.registerAudio();

}
