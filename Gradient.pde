boolean gradient = false;
boolean gradientBox = false;

void gradientBox() {
  gradientBox = (mode == tCircle || mode == tRect);
  
  noFill();
  if (gradientBox)
    gradientBoxFill();
    
  rect(barWidth/2, height-40, 20, 20);
}

void gradientBoxFill() {
  for (int i = 0; i <= 20; i++) {
    stroke(255-i*12.75);
    line(barWidth/2-10+i, height-50, barWidth/2-10+i, height-30);
  }
}
