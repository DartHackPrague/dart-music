
interface IAudioData {
  List getData();
  AudioElement getElement();
  void setMinFreqRatio(double freq);
  void setMaxFreqRatio(double freq); 
  void updateSource(audio);
  String getTitle();
  void setTitle(String title);
}
