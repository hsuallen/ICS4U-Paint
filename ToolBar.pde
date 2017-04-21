class Tool {
  PImage tool;
  int x;
  int y;
  int colour;
  int boxLength;
  boolean clicked;
  String description;
  
  Tool(PImage tool, int y, int colour, String description, int boxLength) {
    this.tool = tool;
    this.x = barWidth/2;
    this.y = y;
    this.colour = colour;
    this.clicked = false;
    this.description = description;
    this.boxLength = boxLength;
  }
  
  void draw() {
    imageMode(CENTER);
    fill(this.colour);
    noStroke();
    rectMode(CENTER);
    rect(this.x, this.y, xToolSquare, yToolSquare, roundCorner);
    image(this.tool, barWidth/2, this.y, toolSize, toolSize);
  }
  
  void mouseClick() {
    int x1 = this.x - xToolSquare / 2; int x2 = this.x + xToolSquare / 2;
    int y1 = this.y - yToolSquare / 2; int y2 = this.y + yToolSquare / 2;
    
    if (mousePressed && mouseX > x1 && mouseX < x2 && mouseY >= y1 && mouseY <= y2) {
      this.colour = 30;
      description();
    } else if (!clicked && mouseX > x1 && mouseX < x2 && mouseY >= y1 && mouseY <= y2) {
      this.colour = 120;
      description();
    } else if (clicked && mouseX > x1 && mouseX < x2 && mouseY >= y1 && mouseY <= y2) {
      this.colour = 50;
      description();
    } else if (clicked) {
      this.colour = 50;
    } else if (!clicked) {
      this.colour = 83;
    }
  }
  
  void description() {
    rectMode(CORNER);
    setA(200, 0);
    rect(barWidth, height-textPadding-15, this.boxLength, 15/2+textPadding*3);
    setFont(LEFT, 15, 0);
    text(this.description, barWidth+textPadding, height-textPadding);
  }
}
