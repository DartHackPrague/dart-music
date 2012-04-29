//randomly change bg color of dom element


class BgColorAnimator {
  Element element;
  RgbColor color;
  int maxColorValue = 255;
  int minColorValue = 230;
  bool minReached = false;
  bool maxReached = false;
  bool incrementing = true; 
  final int colorChangeStep = 3;
  final int colorChangeDelay = 200;

  BgColorAnimator(Element element) {
    this.element = element;
    this.color = this.getRandomColor();
  }

  void changeBgColor() {
    this.element.style.backgroundColor = this.color.toString();
  }

  RgbColor getRandomColor() {
    //Dart bug - random is not random
    int r = DartMath.Random(this.minColorValue, this.maxColorValue);
    int g = DartMath.Random(this.minColorValue, this.maxColorValue);
    int b = DartMath.Random(this.minColorValue, this.maxColorValue);

    return new RgbColor(r, g, b);
  }

  RgbColor getNextColor(RgbColor currentColor) {
    if(incrementing) {
      if(!isMaximal(currentColor.r)) {
        currentColor.r += colorChangeStep;
      } else if(!isMaximal(currentColor.g)) {
        currentColor.g += colorChangeStep;
      } else if(!isMaximal(currentColor.b)) {
        currentColor.b += colorChangeStep;
      } else {
//        print("reached max");
        incrementing = false;
      }
    } else {
      if(!isMinimal(currentColor.r)) {
        currentColor.r -= colorChangeStep;
      } else if(!isMinimal(currentColor.g)) {
        currentColor.g -= colorChangeStep;
      } else if(!isMinimal(currentColor.b)) {
        currentColor.b -= colorChangeStep;
      } else {
//        print("reached min");
        incrementing = true;
      }
    }
    return currentColor;
  }
  
  bool isMaximal(int colorValue) {
    return (colorValue + colorChangeStep) > maxColorValue;
  }
  
  bool isMinimal(int colorValue) {
    return (colorValue - colorChangeStep) < minColorValue;
  }

  void perpetualColorChange() {

    this.color = getNextColor(this.color);

    changeBgColor();

    window.setTimeout(perpetualColorChange, colorChangeDelay);

  }
}