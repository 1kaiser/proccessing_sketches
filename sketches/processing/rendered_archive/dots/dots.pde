
void setup()
{
  size( 7860/3, 4320/3);//size(1440,900);
  eon();
  size( 7860/3, 4320/3);//size(1440,900);
  save("diagonal.jpeg");
}
/* void draw() {

 //background(#C6AB20);
  // This embedded loop skips over values in the arrays based on
  // the spacer variable, so there are more values in the array
  // than are drawn here. Change the value of the spacer variable
  // to change the density of the points
  int  spacer=10;
  smooth(); 
  stroke(#E9ED22);
      strokeWeight(2);
  for (int y = 0; y < height; y += spacer)
  {
    for (int x = 0; x < width; x += spacer)
    {
      
      point(x + spacer/2, y + spacer/2);
    }
  }
  
  strokeWeight(20);
 point(mouseX,mouseY);
 // save("diagonal.jpeg");
}*/
void eon()
{   //background(#7E53ED);
  int  spacer=10;
  noSmooth(); 
  stroke(#FC0A2E);
  //noFill();
      strokeWeight(1);
  for (int y = 0; y < height; y += spacer)
  {
    for (int x = 0; x < width; x += spacer)
    {
      
     point(x + spacer/2, y + spacer/2);
  // ellipse(x + spacer/2, y + spacer/2,10,10);
  }
  }
}

