#import('dart:html');
#import('dart:dom', prefix:'dom');

class DartMusic {

  DartMusic() {
  }

  void run() {
    write("Hello World!");
  }

  void write(String message) {
    // the HTML library defines a global "document" variable
    document.query('#status').innerHTML = message;
  }
  
  void registerAudio() {
    //getting source from audio tag
    dom.AudioContext audioContext = new dom.AudioContext();
    var audio = document.query("audio");
    var source = audioContext.createMediaElementSource(audio);
    dom.AudioGainNode gainNode = audioContext.createGainNode();

    //connecting inputs and outputs
    source.connect(gainNode, 0, 0);
    gainNode.connect(audioContext.destination, 0, 0);

    //volume slider handler
    document.query("#volume").on.change.add((e) {
      var volume = Math.parseInt(e.target.value);
      var max = Math.parseInt(e.target.max);
      var fraction = volume / max;
      gainNode.gain.value = fraction * fraction;
    });
  }
}

void main() {
  DartMusic m = new DartMusic();
  m.run();
  m.registerAudio();
}
