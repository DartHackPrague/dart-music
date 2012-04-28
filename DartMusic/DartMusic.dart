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


  void registerDragNDrop() {
    document.on.drop.add( function( Event event ) {

      event.preventDefault();
      event.stopPropagation();
      print("here!");
      print(event.dataTransfer.getData("Text"));
      print(event.dataTransfer.getData("URL"));
      print(event.target.files[0]);
      print(event.target.files[0].name);


      return false;
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
  DartMusic m = new DartMusic();
  m.run();
  m.registerAudio();

  m.registerDragNDrop();
}
