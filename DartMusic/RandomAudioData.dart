
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
  
}
