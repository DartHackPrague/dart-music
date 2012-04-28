class DragDropHandler {
  
  
  void register() {
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
      reader.readAsDataURL(file);
    }
  }
  
  
  void finishLoading(Event e) {
    print("file loaded ");
    AudioElement audioOld = document.query("audio");
    
    AudioElement audio = new AudioElement();
    audio.src = e.target.result;
    audio.controls = true;
    audioOld.replaceWith(audio);
  }
  
  
}
