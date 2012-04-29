class RgbColor {
  int r;
  int g;
  int b;
  double opacity;

  RgbColor(int r, int g, int b) {
    this.r = r;
    this.g = b;
    this.b = b;
    this.opacity = 1/1;
  }

  String toString() {
    String value = 'rgba(' +  this.r.toString() + ',' + this.g.toString() + ',' + this.b.toString() + ',' + this.opacity + ')';
    return value;
  }
}
