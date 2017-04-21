final int barWidth = 40;
final int toolSize = 20;
final int xToolSquare = 30;
final int yToolSquare = 25;
final int roundCorner = 5;
final int textPadding = 5;
final int toolSpacing = 30;

PImage pen, brush, eraser, bucket, circle, square, line;

void shortcut() {
  if (key == 'p') {
    reset(); mode = tPen;
    tools[tPen].clicked = true;
  } else if (key == 'b') {
    reset(); mode = tBrush;
    tools[tBrush].clicked = true;
  } else if (key == 'e') {
    reset(); mode = tEraser;
    tools[tEraser].clicked = true;
  } else if (key == 'g') {
    reset(); mode = tBucket;
    tools[tBucket].clicked = true;
  } else if (key == 'c') {
    reset(); mode = tCircle;
    tools[tCircle].clicked = true;
  } else if (key == 'r') {
    reset(); mode = tRect;
    tools[tRect].clicked = true;
  } else if (key == 'l') {
    reset(); mode = tLine;
    tools[tLine].clicked = true;
  }
}

void toolsInitialize() {
  pen = loadImage("pen.png");
  brush = loadImage("brush.png");
  eraser = loadImage("eraser.png");
  bucket = loadImage("bucket.png");
  circle = loadImage("circle.png");
  square = loadImage("square.png");
  line = loadImage("line.png");
  
  tools[tPen] = new Tool(pen, height/2-toolSpacing*3, 50, "Pen Tool", 65);
  tools[tBrush] = new Tool(brush, height/2-toolSpacing*2, 83, "Brush Tool", 78);
  tools[tEraser] = new Tool(eraser, height/2-toolSpacing, 83, "Eraser Tool", 82);
  tools[tBucket] = new Tool(bucket, height/2, 83, "Bucket Tool", 85);
  tools[tCircle] = new Tool(circle, height/2+toolSpacing, 83, "Circle Tool", 78);
  tools[tRect] = new Tool(square, height/2+toolSpacing*2, 83, "Square Tool", 84);
  tools[tLine] = new Tool(line, height/2+toolSpacing*3, 83, "Line Tool", 68);
  tools[0].clicked = true;
}

void drawTools() {
  rectMode(CENTER);
  setA(83, 150);
  rect(barWidth/2, height/2+20, barWidth, height);
  
  for (int i = 0; i < tools.length; i++) {
    tools[i].draw();
    tools[i].mouseClick();
  }
}

void reset() {
  for (int i = 0; i < tools.length; i++) {
    tools[i].clicked = false;
    firstClick = false;
  }
}
