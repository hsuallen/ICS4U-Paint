PFont globalFont;

void setFont(int align, int size, int greyScale) {
  textFont(globalFont);
  textAlign(align);
  textSize(size);
  fill(greyScale);
}

void setA(int greyScale, int stroke) {
  fill(greyScale);
  stroke(stroke);
}

void setA(int r, int g, int b) {
  fill(r, g, b);
}

void setA(int r, int g, int b, int stroke) {
  setA(r, g, b);
  stroke(stroke);
}

void setA(int r, int g, int b, int rStroke, int gStroke, int bStroke) {
  setA(r, g, b);
  stroke(rStroke, gStroke, bStroke);
}

void setA(int r, int g, int b, int stroke, int weight) {
  setA(r, g, b);
  stroke(stroke);
  strokeWeight(weight);
}

void setA(int r, int g, int b, int rStroke, int gStroke, int bStroke, int weight) {
  setA(r, g, b);
  stroke(rStroke, gStroke, bStroke);
  strokeWeight(weight);
}
