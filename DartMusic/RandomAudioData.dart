
class RandomAudioData implements IAudioData {
  
  List getData() {
    List data = new List();
    
    for (var i = 0; i < 1024; i++) {
      data.add((Math.random() * 255).round());
    }
    
    return data;
  }
}
