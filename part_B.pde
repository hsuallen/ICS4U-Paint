// constant modes, tried enum but does not work
final int tPen = 0;
final int tBrush = 1;
final int tEraser = 2;
final int tBucket = 3;
final int tCircle = 4;
final int tRect= 5;
final int tLine = 6;

PGraphics buffer; // off-screen buffer
Tool[] tools = new Tool[7];
int mode = 0;

void setup() {
  size(800, 600);
  smooth();
  globalFont = createFont("Cambria.ttf", 12);      
  toolsInitialize();
  bufferInitialize();
}

void draw() {
  background(255);
  updateBuffer();
  colourSwatch();
  bufferDisplay();
  drawTools();
  bufferColour();
  checkAlign();
  gradientBox();
  saveGraphics();
  println(fileClick);
}

void mouseReleased() {
  if (!colourClick) {
    if (mode == tBucket && mouseX > barWidth && mouseButton == LEFT) {
      bufferBucket();
    } else if (mode == tCircle && mouseX > barWidth && mouseButton == LEFT) {
      bufferCircle();
    } else if (mode == tRect && mouseX > barWidth && mouseButton == LEFT) {
      bufferRect();
    } else if (mode == tLine && mouseX > barWidth && mouseButton == LEFT) {
      bufferLine();
    }
  }
  
  if (mouseButton == RIGHT) {
    colourClick = true;
    firstClick = false;
    checkCoords();
    setColourSwatch();
  }

  if (colourClick) {
    checkColourSwatch();
  }
  
  fileClick();

  for (int i = 0; i < tools.length; i++) {
    if (mouseX >= tools[i].x-xToolSquare/2 && mouseX <= tools[i].x+xToolSquare/2 && mouseY >= tools[i].y-yToolSquare/2 && mouseY <= tools[i].y+yToolSquare/2) {
      reset();
      tools[i].clicked = true;
      mode = i;
    }
  }
}

void mouseWheel(MouseEvent event) {
  float n = event.getAmount();
  gColour += n*5;

  if (gColour > 254) {
    gColour = 255;
  } 
  else if (gColour < 1) {
    gColour = 0;
  }
}

void checkAlign() {
  if (key == CODED) {
    if (keyPressed && keyCode == ALT && firstClick) {
      alignment = CENTER;
    } else {
      alignment = CORNER;
    }
  }
}

void keyPressed() {  
  shortcut();

  if (key == 32) {
    fill = !fill;
  }
  if (key == CODED) {
    if (keyCode == CONTROL) {
      stroke = !stroke;
    }
  }

  if (key == '=' && firstClick) 
    sSize += 1;
  else if (key == '=')
    gSize += 5;
  else if (key == '-' && firstClick)
    sSize -= 1;
  else if (key == '-')
    gSize -= 5;
}

