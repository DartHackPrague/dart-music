
class RandomAudioData implements IAudioData {
  
  static final LENGTH = 1024;
  
  List getData() {
    List data = new List();
    
    for (var i = 0; i < LENGTH; i++) {
      data.add((Math.random() * 255).round());
    }
    
    return data;
  }
  
  AudioElement getElement() {
    return null;
  }
  
  void setMinFreqRatio(double freq) { }
  
  void setMaxFreqRatio(double freq) { }
  
  String getTitle() { return ""; }
  
  void setTitle(String title) { } 
  
  void updateSource(AudioElement audio) { }
}
