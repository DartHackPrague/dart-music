
class MP3AudioData implements IAudioData {
  
  dom.RealtimeAnalyserNode _analyser;
  AudioElement _elm;
  dom.BiquadFilterNode _highpassFilter;
  dom.BiquadFilterNode _lowpassFilter;
  int _freqMin = 0;
  int _freqMax = 20000;
  
  MP3AudioData(audio) {
    this._elm = audio;
    dom.AudioContext audioContext = new dom.AudioContext();
    var source = audioContext.createMediaElementSource(audio);
    dom.AudioGainNode volumeNode = audioContext.createGainNode();
    this._analyser = audioContext.createAnalyser();

    _lowpassFilter = audioContext.createBiquadFilter();
    _lowpassFilter.type = BiquadFilterNode.LOWPASS;
    _lowpassFilter.frequency.value = _freqMax;

    _highpassFilter = audioContext.createBiquadFilter();
    _highpassFilter.type = BiquadFilterNode.HIGHPASS;
    _highpassFilter.frequency.value = _freqMin;
    
    source.connect(_lowpassFilter, 0, 0);
    _lowpassFilter.connect(_highpassFilter, 0, 0);
    _highpassFilter.connect(_analyser, 0, 0);
    this._analyser.connect(audioContext.destination, 0, 0);
  }
  
  
  List getData() {
    var arr = new Uint8Array(_analyser.frequencyBinCount);
    _analyser.getByteFrequencyData(arr);
    return arr;
  }
  
  AudioElement getElement() {
    return this._elm;
  }
  
  void setMaxFreq(int freq) {
    _freqMax = freq;
    _lowpassFilter.frequency.value = _freqMax;
  }
  
  void setMinFreq(int freq) {
    _freqMin = freq;
    _highpassFilter.frequency.value = _freqMin;
  }
}
