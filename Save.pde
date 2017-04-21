Option[] options = new Option[4];
boolean fileClick = false;

void saveGraphics() {
  saveBar();
}

void saveBar() {
  rectMode(CORNER);
  noStroke();
  fill(120);
  rect(0, 0, width, 20);
  
  setFont(CENTER, 15, 0);
  text("File", 25, 15);
}

void fileClick() {
  boolean coords = (mouseX > 10 && mouseX < 50 && mouseY > 0 && mouseY < 20);
  if (!fileClick && coords) {
    fileClick = true;
  }
}

void fileOptions() {
  
}
