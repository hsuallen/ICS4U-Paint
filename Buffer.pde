import java.util.LinkedList;

int alignment = CORNER; // the global alignment for drawing shapes
int gSize = 20;
int sSize = 1;
int x1, y1;
boolean fill = false;
boolean stroke = true;
boolean firstClick = false;

void bufferInitialize() {
  buffer = createGraphics(width-barWidth, height);
  buffer.beginDraw();
  buffer.background(255);
  buffer.endDraw();
}

void updateBuffer() {
  if (mousePressed && mouseButton == LEFT) {
    bufferSwitch();
  }
  if (mousePressed && (mouseX <= xc-5 || mouseX >= xc+colourPadding*3+colourgSize*2 || mouseY <= yc-5 || mouseY >= yc+colourPadding*5+colourgSize*4)) {
      colourClick = false;
  }
  
  gSize = max(gSize, 0);
  sSize = max(sSize, 1);
  
  if (mouseX < barWidth) {
    firstClick = false;
  }
  
  image(buffer, width/2+barWidth/2, height/2);
}

void bufferDisplay() {
  if (colourClick) {
    cursor(HAND);
  } else if (mouseX >= barWidth) {
    noCursor();
    noFill();
    ellipseMode(CENTER);
    switch(mode) {
      case tPen: noFill(); stroke(0); ellipse(mouseX, mouseY, 3, 3); break;
      case tBrush: stroke(0); ellipse(mouseX, mouseY, gSize, gSize); break;
      case tEraser: stroke(0); ellipse(mouseX, mouseY, gSize, gSize); break;
      case tBucket: image(bucket, mouseX, mouseY); break;
      case tCircle: cursor(CROSS); break;
      case tRect: cursor(CROSS); break;
      case tLine: cursor(CROSS); break;
    }
  } else cursor(HAND);
  pushStyle();
  strokeWeight(sSize);
  stroke(0);
  if (fill) fill(gColour);
  else noFill();
  if (stroke) stroke(0);
  else noStroke();
  
  if (firstClick && mode == tCircle) {
    ellipseMode(alignment);
    ellipse(x1, y1, mouseX-x1, mouseY-y1);
  } else if (firstClick && mode == tRect) {
    rectMode(alignment);
    rect(x1, y1, mouseX-x1, mouseY-y1);
  } else if (firstClick && mode == tLine) {
    stroke(gColour);
    line(x1, y1, mouseX, mouseY);
  }
  popStyle();
}

void bufferSwitch() {
  if (!colourClick) {
    switch(mode) {
      case tPen: buffer.stroke(gColour); bufferPen(); break;
      case tBrush: buffer.stroke(gColour); bufferBrush(); break;
      case tEraser: buffer.stroke(255); bufferBrush(); break;
    }
  }
}

void colourSwatch() {
  if (colourClick) {
    rectMode(CORNER);
    setA(255, 0);
    rect(xc, yc, colourPadding*3+colourgSize*2, colourPadding*5+colourgSize*4);
    drawColourSwatch();
  }
}

void bufferColour() {
  rectMode(CENTER);
  fill(gColour);
  stroke(255);
  rect(barWidth/2, height-170, 20, 20);
}

void bufferPen() {
  buffer.beginDraw();
  buffer.strokeWeight(2);
  buffer.ellipseMode(CENTER);
  buffer.line(mouseX-barWidth, mouseY, pmouseX-barWidth, pmouseY);
  buffer.endDraw();
}

void bufferBrush() {
  buffer.beginDraw();
  buffer.strokeWeight(gSize);
  buffer.ellipseMode(CENTER);
  buffer.line(mouseX-barWidth, mouseY, pmouseX-barWidth, pmouseY);
  buffer.endDraw();
}

void bufferBucket() {
  buffer.loadPixels();
  Node start = new Node(mouseX-barWidth, mouseY);
  //fillRecursive(x, y);
  floodFill(start, start.get(), gColour);
  buffer.updatePixels();
//  buffer.beginDraw();
//  for (int i = 0; i < 760; i++) {
//    buffer.stroke(i);
//    buffer.line(i, 0, i, height);
//  }
//  buffer.endDraw();
}

class Node {
  int x;
  int y;
  
  Node(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  boolean inBounds() {
    return x >= 0 && x < buffer.width && y >= 0 && y < buffer.width;
  }
  
  boolean notEdge() {
    return x > 0 && x < buffer.width-1 && y > 0 && y < buffer.height-1;
  }
  
  color get() {
    return buffer.pixels[y*buffer.width+x];
  }
  
  void set(color c) {
    buffer.pixels[y*buffer.width+x] = c;
  }
  
  Node copy() {
    return new Node(x, y);
  }
}

void floodFill(Node start, color c1, color c2) {
  LinkedList<Node> q = new LinkedList<Node>();
  if (start.get() != c1) return;
  q.add(start);
  for (int i = 0; i < q.size(); i++) {
    Node n = q.get(i);
    if (n.get() == c1) {
      Node west = n.copy();
      Node east = n.copy();
      while (west.notEdge() && west.get() == c1) {
        west.x--;
      }
      while (east.notEdge() && east.get() == c1) {
        east.x++;
      }
      while (west.x <= east.x) {
        west.set(c2);
        Node north = new Node(west.x, west.y-1);
        if (north.inBounds() && north.get() == c1) {
          q.add(north);
        }
        Node south = new Node(west.x, west.y+1);
        if (south.inBounds() && south.get() == c1) {
          q.add(south);
        }
        west.x++;
      }
    }
  }
}

/*
void fillRecursive(int x, int y) {
  boolean inBounds = (x >= 0 && x < buffer.width && y >= 0 && y < buffer.height);
  if (inBounds && getPixel(buffer, x, y) == gFillOldColour) {
    setPixel(buffer, x, y, gColour);
    fillRecursive(x-1, y);
    fillRecursive(x, y-1);
    fillRecursive(x, y+1);
    fillRecursive(x+1, y);
  }
}
*/

void checkFill() {
  if (fill) buffer.fill(gColour);
  else buffer.noFill();

  if (stroke) buffer.stroke(0);
  else buffer.noStroke();
}

void bufferCircle() {
  buffer.beginDraw();
  checkFill();
  if (!firstClick) {
    x1 = mouseX;
    y1 = mouseY;
    firstClick = true;
  } else if (firstClick) {
    firstClick = false;
  }
  buffer.ellipseMode(alignment);
  buffer.strokeWeight(sSize);
  buffer.ellipse(x1-40, y1, mouseX-x1, mouseY-y1);
  buffer.endDraw();
}

void bufferRect() {
  buffer.beginDraw();
  checkFill();
  if (!firstClick) {
    x1 = mouseX;
    y1 = mouseY;
    firstClick = true;
  } else if (firstClick) {
    firstClick = false;
  }
  rectMode(alignment);
  buffer.strokeWeight(sSize);
  buffer.rect(x1-40, y1, mouseX-x1, mouseY-y1);
  buffer.endDraw();
}

void bufferLine() {
  buffer.beginDraw();
  buffer.noFill();
  buffer.stroke(gColour);
  if (!firstClick) {
    x1 = mouseX;
    y1 = mouseY;
    firstClick = true;
  } else if (firstClick) {
    firstClick = false;
  }
  buffer.strokeWeight(sSize);
  buffer.line(x1-40, y1, mouseX-40, mouseY);
  buffer.endDraw();
}
