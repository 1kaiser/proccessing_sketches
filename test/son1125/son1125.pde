int l=100, p=500, c1=1, i1=5, i2;
float a=1, b=100, i, k, j=20, m1=0, m2=0, m3;
float inc = radians(15), re=radians(30);
String  sentence="5";
//PFont //font1;
color c;
//PImage //img;


void setup() {
  //size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  //size( 7860/3, 4320/3);//size( 8192/3, 5120/3);
  ////background(50);

  //img = loadImage("v.jpg");
  int ll=1;
  size( 7860/3, 4320/3);//size( 7860*ll, 4320*ll);
  //image(//img, 0, 0, width, height);
  filter(GRAY);
  filter(BLUR, 10);

  save("sat11X20.png");
}

