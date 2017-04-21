final int colourgSize = 25;                   // gSize of the swatch squares
final int colourPadding = 5;                  // the swatch paddings
final color black = color(0);                 // constant black colour
final color white = color(255);               // constant white colour
final color red = color(255, 0, 0);           // constant red colour
final color orange = color(255, 102, 0);      // constant orange colour
final color yellow = color(255, 255, 0);      // constant yellow colour
final color green = color(0, 255, 0);         // constant green colour
final color blue = color(0, 0, 255);          // constant blue colour
final color purple = color(154, 0, 255);      // constant purple colour

int gColour = 0; // global colour, works with the pen, brush, and bucket tool
Colour[] colours = new Colour[8];
float xc, yc; // x colour swatch, y colour swatch
boolean colourClick = false;

void setColourSwatch() {
  rectMode(CORNER);
  colours[0] = new Colour(xc+colourPadding+colourgSize/2, yc+colourPadding+colourgSize/2, white);
  colours[1] = new Colour(xc+colourPadding*2+colourgSize*1.5, yc+colourPadding+colourgSize/2, black);
  colours[2] = new Colour(xc+colourPadding+colourgSize/2, yc+colourPadding*2+colourgSize*1.5, red);
  colours[3] = new Colour(xc+colourPadding*2+colourgSize*1.5, yc+colourPadding*2+colourgSize*1.5, orange);
  colours[4] = new Colour(xc+colourPadding+colourgSize/2, yc+colourPadding*3+colourgSize*2.5, yellow);
  colours[5] = new Colour(xc+colourPadding*2+colourgSize*1.5, yc+colourPadding*3+colourgSize*2.5, green);
  colours[6] = new Colour(xc+colourPadding+colourgSize/2, yc+colourPadding*4+colourgSize*3.5, blue);
  colours[7] = new Colour(xc+colourPadding*2+colourgSize*1.5, yc+colourPadding*4+colourgSize*3.5, purple);
}

void checkColourSwatch() {
  for (int i = 0; i < colours.length; i++) {
    if (mouseX > colours[i].x-colourgSize/2 && mouseX < colours[i].x+colourgSize/2 && mouseY > colours[i].y-colourgSize/2 && mouseY < colours[i].y+colourgSize/2) {
      gColour = colours[i].colour;
      colourClick = false;
    }
  }
}

void drawColourSwatch() {
  for (int i = 0; i < colours.length; i++) {
    colours[i].draw();
  }
}

void checkCoords() {
  float xBound = colourPadding*3+colourgSize*2;
  float yBound = colourPadding*5+colourgSize*4;
  if (mouseX > width-xBound && mouseY > height-yBound) {
    xc = mouseX - xBound;
    yc = mouseY - yBound;
  } else if (mouseX > width-xBound) {
    xc = mouseX - xBound;
    yc = mouseY;
  } else if (mouseY > height-yBound) {
    xc = mouseX;
    yc = mouseY - yBound;
  } else {
    xc = mouseX;
    yc = mouseY;
  }
}

class Colour {
  float x;
  float y;
  color colour;
  
  Colour(float x, float y, color colour) {
    this.x = x;
    this.y = y;
    this.colour = colour;
  }
  
  void draw() {
    rectMode(CENTER);
    stroke(0);
    fill(this.colour);
    rect(this.x, this.y, colourgSize, colourgSize);
  }
}
