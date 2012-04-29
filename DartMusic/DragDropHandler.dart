class DragDropHandler {
  DartMusic _dm;
  
  void register(DartMusic m) {
    _dm = m;
    document.on.drop.add(handleDrop);
  }
  
  void handleDrop(MouseEvent event) {
    event.preventDefault();
    event.stopPropagation();

    //obtaining file path
    FileList files = event.dataTransfer.files;
    FileReader reader = new FileReader();

    reader.on.load.add(finishLoading);
    for(int i = 0; i < files.length; i++) {
      File file = files.item(i);
      print("dragged file: "+file.name);
      //asynchronous load of dragged file (will call finishLoading callback when finished)
      reader.readAsDataURL(file);
    }
  }
  
  void finishLoading(Event e) {
    print("file loaded ");
    AudioElement audioOld = document.query("audio");
    
    AudioElement audio = new AudioElement();
    audio.src = e.target.result;
    audio.controls = false;
    audio.autoplay = true;
    audio.loop = true;
    audioOld.replaceWith(audio);
    window.setTimeout(() {
      IAudioData data = _dm.getAudioData();
      data.updateSource(audio);
      _dm.setAudioSource(data);
    }, 550);
  }
  
  
}
