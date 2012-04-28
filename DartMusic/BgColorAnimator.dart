//randomly change bg color of dom element


class BgColorAnimator {
  Element element;
  RgbColor color;
  int maxColorValue = 255;
  int minColorValue = 0;
  bool minReached = false;
  bool maxReached = false;

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
    if (maxReached == false && (currentColor.r <= maxColorValue || currentColor.g <= maxColorValue || currentColor.b <= maxColorValue)) {
      if (currentColor.r < maxColorValue) {
        currentColor.r++;
      }
      else if (currentColor.g < maxColorValue) {
        currentColor.g++;
      }
      else if (currentColor.b < maxColorValue) {
        currentColor.b++;
      }
      else {
        maxReached = true;
        minReached = false;
      }
    }
    else if (maxReached == true) {
      if (currentColor.r > minColorValue && currentColor.r <= maxColorValue) {
        currentColor.r--;
      }
      else if (currentColor.g > minColorValue && currentColor.g <= maxColorValue) {
        currentColor.g--;
      }
      else if (currentColor.b > minColorValue && currentColor.b <= maxColorValue) {
        currentColor.b--;
      }
      else {
        maxReached = false;
        minReached = true;
      }
    }


    return currentColor;
  }

  void perpetualColorChange() {

    this.color = getNextColor(this.color);

    changeBgColor();

    window.setTimeout(perpetualColorChange, 15);

  }
}