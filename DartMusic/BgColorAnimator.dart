//randomly change bg color of dom element


class BgColorAnimator {
  Element element;
  RgbColor color;

  BgColorAnimator(Element element) {
    this.element = element;
    this.color = new RgbColor(200, 90, 40);
  }

  void changeBgColor() {
    this.element.style.backgroundColor = this.color.toString();
  }
}