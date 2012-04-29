#import('dart:html');
#import('dart:dom', prefix:'dom');

#source('IAudioData.dart');
#source('IRenderer.dart');
#source('RandomAudioData.dart');
#source('MP3AudioData.dart');
#source('CanvasRenderer.dart');
#source('BgColorAnimator.dart');
#source('RgbColor.dart');
#source('DragDropHandler.dart');

#source('CanvasCircleRenderer.dart');
#source('CanvasCircle.dart');
#source('Position.dart');


class DartMusic {

  IAudioData _audioData;
  List _effects;

  DartMusic() {
    this._effects = new List();

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
      effect.setAudioElement(audio.getElement());
    }
  }

}

void main() {
  Element body = document.query("body");
  BgColorAnimator animator = new BgColorAnimator(body);
  animator.perpetualColorChange();

  //IAudioData audioData = new RandomAudioData();

  DartMusic m = new DartMusic();
  m.addEffect(new CanvasRenderer(document.query('#drawHere'), document.query("#playMe")));
  m.addEffect(new CanvasCircleRenderer(document.query('#drawCirclesHere')));
  m.setAudioSource(new MP3AudioData(document.query("#playMe")));
  window.setTimeout(f() => m.run(), 50);
  
  DragDropHandler dragDrop = new DragDropHandler();
  dragDrop.register(m);

}
