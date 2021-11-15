/**
 * Array 2D. 
 * 
 * Demonstrates the syntax for creating a two-dimensional (2D) array.
 * Values in a 2D array are accessed through two index values.  
 * 2D arrays are useful for storing images. In this example, each dot 
 * is colored in relation to its distance from the center of the image. 
 */


int spacer;

void setup() {
   background(0);
  size(7860,4320);

spacer=20;
if((height%2==0)&&(width%2==0))
{
  for (int y =  0; y < height; y+=spacer) {
    for (int x= 0; x < width; x+=spacer) {
      noSmooth();

      stroke(255);strokeWeight(1);
      point(x + spacer/2, y + spacer/2);
    }
  }
}
  save("diagonal.tif");
  // noLoop();  // Run once and stop
}

/*void draw() {
 background(0);
 // This embedded loop skips over values in the arrays based on
 // the spacer variable, so there are more values in the array
 // than are drawn here. Change the value of the spacer variable
 // to change the density of the points
 for (int y = 0; y < height; y += spacer) {
 for (int x = 0; x < width; x += spacer) {
 stroke(distances[x][y]);
 
 }
 }
 }
 */

