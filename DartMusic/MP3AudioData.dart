
class MP3AudioData implements IAudioData {
  
  RealtimeAnalyserNode _analyser;
  AudioElement _elm;
  BiquadFilterNode _highpassFilter;
  BiquadFilterNode _lowpassFilter;
  int _freqMin = 0;
  int _freqMax = 20000;
  int freqMaxTotal = 20000;
  AudioContext audioContext;
  var source;
  String _title;
  
  MP3AudioData(AudioElement audio) {
    this._elm = audio;
    _title = "";
    audioContext = new AudioContext();
    source = audioContext.createMediaElementSource(audio);
    AudioGainNode volumeNode = audioContext.createGainNode();
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
  
  void updateSource(AudioElement audio) {
    this._elm = audio;
    var newSource = audioContext.createMediaElementSource(audio);
    source.disconnect(0);
    newSource.connect(_lowpassFilter, 0, 0);
  }
  
  List getData() {
    var arr = new Uint8Array(_analyser.frequencyBinCount);
    _analyser.getByteFrequencyData(arr);
    return arr;
  }
  
  AudioElement getElement() {
    return this._elm;
  }
  
  void setMaxFreqRatio(double freq) {
    _freqMax = (freq*freqMaxTotal).toInt();
    _lowpassFilter.frequency.value = _freqMax;
  }
  
  void setMinFreqRatio(double freq) {
    _freqMin = (freq*freqMaxTotal).toInt();
    _highpassFilter.frequency.value = _freqMin;
  }
  
  String getTitle() {
    return _title;
  }
  
  void setTitle(String title) {
    _title = title;
  }
}
