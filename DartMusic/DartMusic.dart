#import('dart:html');
#import('dart:core');

#source('IAudioData.dart');
#source('IRenderer.dart');
#source('RandomAudioData.dart');
#source('MP3AudioData.dart');
#source('CanvasRenderer.dart');
#source('BgColorAnimator.dart');
#source('RgbColor.dart');
#source('DragDropHandler.dart');

#source('DartMath.dart');
#source('CanvasCircleRenderer.dart');
#source('CanvasCircle.dart');
#source('Position.dart');
#source('EasterEgg.dart');


class DartMusic {

  IAudioData _audioData;
  List _effects;
  EasterEgg _egg;

  DartMusic() {
    this._effects = new List();
    this._egg = new EasterEgg();

    window.on.resize.add((Event e) {
      for (final effect in this._effects) {
        effect.resize();
      }
    });
  }

  void update(int time) {
    var data = this._audioData.getData();
    for (final effect in this._effects) {
      effect.render(data, time);
    }
    window.webkitRequestAnimationFrame(this.update);
  }

  void run() {
    window.webkitRequestAnimationFrame(this.update);
  }

  void addEffect(IRenderer effect) {
    this._effects.add(effect);
  }

  void setAudioSource(IAudioData audio) {
    this._audioData = audio;
    for (final effect in this._effects) {
      effect.setAudioElement(audio);
    }
  }

  void _showAboutDialog() {
    Element dialog = document.query("#aboutDialog");
    dialog.style.display = "block";
  }

  void _hideAboutDialog() {
    Element dialog = document.query("#aboutDialog");
    dialog.style.display = "none";
  }

  IAudioData getAudioData() {
    return _audioData;
  }

  void setButtonsListener() {
    AudioElement elm = this._audioData.getElement();
    ButtonElement playPauseButton = document.query("#playPauseButton");
    
    
    var eggButton = document.query("#eggButton");
    var aboutButton = document.query("#aboutButton");
    var closeAboutButton = document.query("#closeAboutButton");

    playPauseButton.on.click.add((Event event) {
      if (elm.paused) {
        playPauseButton.text = 'Pause';
        this._audioData.getElement().play();
      } else {
        playPauseButton.text = 'Play';
        this._audioData.getElement().pause();
      }
    });

    /*eggButton.on.click.add((Event event) {
      _egg.Surprise();
    });*/

    aboutButton.on.click.add((Event event) {
      _showAboutDialog();
    });

    closeAboutButton.on.click.add((Event event) {
      _hideAboutDialog();
    });
  }
}

void main() {
  Element body = document.query("body");
  BgColorAnimator animator = new BgColorAnimator(body);
  animator.perpetualColorChange();

  //IAudioData audioData = new RandomAudioData();
  IAudioData audioData = new MP3AudioData(document.query("#playMe"));

  DartMusic m = new DartMusic();
  m.addEffect(new CanvasCircleRenderer(document.query('#drawCirclesHere')));

  CanvasRenderer cr = new CanvasRenderer(document.query('#drawHere'), document.query("#playMe"));
  cr.onSelectionChanged((List sel) {
    audioData.setMinFreqRatio(sel[0]);
    audioData.setMaxFreqRatio(sel[1]);
  });
  m.addEffect(cr);

  m.setAudioSource(audioData);
  m.run();

  DragDropHandler dragDrop = new DragDropHandler();
  dragDrop.register(m);

  m.setButtonsListener();
}
