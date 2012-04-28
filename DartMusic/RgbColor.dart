class RgbColor {
  int r;
  int g;
  int b;

  RgbColor(int r, int g, int b) {
    this.r = r;
    this.g = b;
    this.b = b;
  }

  String toString() {
    String value = 'rgb(' +  this.r.toString() + ',' + this.g.toString() + ',' + this.b.toString() + ')';
    return value;
  }
}
