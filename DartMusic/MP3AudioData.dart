
class MP3AudioData implements IAudioData {
  
  dom.RealtimeAnalyserNode _analyser;
  
  MP3AudioData(audio) {
    dom.AudioContext audioContext = new dom.AudioContext();
    var source = audioContext.createMediaElementSource(audio);
    dom.AudioGainNode volumeNode = audioContext.createGainNode();

    this._analyser = audioContext.createAnalyser();
    source.connect(_analyser, 0, 0);
    
    this._analyser.connect(volumeNode, 0, 0);
    volumeNode.connect(audioContext.destination, 0, 0);

  }
  
  
  List getData() {
    var arr = new Uint8Array(_analyser.frequencyBinCount);
    _analyser.getByteFrequencyData(arr);
    return arr;
  }
}
