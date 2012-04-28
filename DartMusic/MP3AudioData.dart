
class MP3AudioData implements IAudioData {
  
  dom.RealtimeAnalyserNode analyser;
  
  MP3AudioData(audio) {
    dom.AudioContext audioContext = new dom.AudioContext();
    var source = audioContext.createMediaElementSource(audio);
    dom.AudioGainNode volumeNode = audioContext.createGainNode();

    this.analyser = audioContext.createAnalyser();
    source.connect(analyser, 0, 0);
    
    this.analyser.connect(volumeNode, 0, 0);
    volumeNode.connect(audioContext.destination, 0, 0);

  }
  
  
  List getData() {
    var arr = new Uint8Array(analyser.frequencyBinCount);
    analyser.getByteFrequencyData(arr);
    return arr;
  }
}
