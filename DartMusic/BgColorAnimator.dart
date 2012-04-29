//randomly change bg color of dom element


class BgColorAnimator {
  Element element;
  RgbColor color;
  int maxColorValue = 255;
  int minColorValue = 0;
  bool minReached = false;
  bool maxReached = false;
  bool incrementing = true; 
  final int colorChangeStep = 10;
  final int colorChangeDelay = 200;

  BgColorAnimator(Element element) {
    this.element = element;
    this.color = new RgbColor(200, 90, 40);
  }

  void changeBgColor() {
    this.element.style.backgroundColor = this.color.toString();
  }

  RgbColor getRandomColor() {
    //Dart bug - random is not random
    int r = 10;
    int g = 50;
    int b = 200;

    RgbColor randomColor = new RgbColor(r, g, b);
    return randomColor;
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
        print("reached max");
        incrementing = false;
      }
    } else {
      if(!isMinimal(currentColor.r)) {
        currentColor.r += colorChangeStep;
      } else if(!isMinimal(currentColor.g)) {
        currentColor.g += colorChangeStep;
      } else if(!isMinimal(currentColor.b)) {
        currentColor.b += colorChangeStep;
      } else {
        print("reached min");
        incrementing = true;
      }
    }
//    
//    if (maxReached == false && (currentColor.r <= maxColorValue || currentColor.g <= maxColorValue || currentColor.b <= maxColorValue)) {
//      if (currentColor.r < maxColorValue) {
//        currentColor.r++;
//      }
//      else if (currentColor.g < maxColorValue - colorChangeStep) {
//        currentColor.g++;
//      }
//      else if (currentColor.b < maxColorValue - color) {
//        currentColor.b++;
//      }
//      else {
//        maxReached = true;
//        minReached = false;
//      }
//    }
//    else if (maxReached == true) {
//      if (currentColor.r > minColorValue && currentColor.r <= maxColorValue) {
//        currentColor.r--;
//      }
//      else if (currentColor.g > minColorValue && currentColor.g <= maxColorValue) {
//        currentColor.g--;
//      }
//      else if (currentColor.b > minColorValue && currentColor.b <= maxColorValue) {
//        currentColor.b--;
//      }
//      else {
//        maxReached = false;
//        minReached = true;
//      }
//    }
//
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