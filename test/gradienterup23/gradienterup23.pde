float i, j, spacer=10, fs=900, ////font size( 7860/3, 4320/3);//size 
n=10, //length of plus 
t=1, //stroke//img.width for plus sign
p;
//PFont //font;

String sentence="HAPPY\nRAINS";//text in the output 
color  c1= color(255, 0, 0, 100), ////background upper gradient 
c2= color(0, 0, 255, 100), ////background lower gradient 
c3= color(0), //dot colour 
c5= color(49, 164, 255, 200), //text colour 
c6= color(255, 255, 255, 50);// plus colour 
/*c1= color(0, 82, 131), ////background upper gradient 
 c2= color(0, 159, 255), ////background lower gradient 
 */



//PImage //img;


void setup()
{

  // //background(0, 112, 201, 150);
  ////img=loadImage("IMG_20140914_131831.jpg");
  //size( 7860/3, 4320/3);//size( 7860, 4320 );
  // size( 7860/3, 4320/3);//size(  5120, 8192 );
  //img = loadImage("w (4).jpg");
  size( 7860/3, 4320/3);//size(  //img.width*3, //img.height/2 *3);
  //image(//img, -width*.80, -height*1.70, width*2.50, height*5);
  filter(THRESHOLD, 0.25);

  float n1=.07;
  float n2=.85;  
  float rad=.2*height;
  float s1=rad/1.6;
  noFill();
  stroke(255, 20, 20);
  strokeWeight(min(width, height)/50);
  strokeJoin(MITER);
  noSmooth();
  beginShape();
  for (float n=0; n<360; n=n+120)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    vertex(a1, a2);///
  }
  endShape(CLOSE);


  save("xcs2.png");
}
//23.2143771,77.4140177

void setGradient(int x, int y, float w, float h, color c1, color c2)
{


  noFill();

  {  // Top to bottom gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      noSmooth();
      line(i, y, i, y+h);
    }
  }
}

