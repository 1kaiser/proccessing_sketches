
void setup()
{  
  size(7860,4320);

  background(#000000);
  float x, y;
  x=width;
  y=height;




  fill(#F70000);
  noStroke();
  smooth();
  ellipse(x/2, y/2,x/12,x/12);  
  //fill(#C12D2D);
  stroke(#F7F7F7);
  strokeWeight(10);
  noFill();
  smooth();
  ellipse(x/2, y/2, x/10, x/10);
  saveFrame("diag.jpeg");
}

