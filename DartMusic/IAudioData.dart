
interface IAudioData {
  List getData();
  AudioElement getElement();
  void setMinFreqRatio(double freq);
  void setMaxFreqRatio(double freq); 
  void updateSource(AudioElement audio);
  String getTitle();
  void setTitle(String title);
}
