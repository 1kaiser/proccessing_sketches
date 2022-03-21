int i, // x axis 
j, //y axis 
o, m; // important parameter for control of propagating triangles 


float 
n=100, // central circle radius 
a=n, //radius of curve 
b=0.2, // tightness of curve 
t1, t2, a1, a2, b1, b2, c1, c2, d1, d2, e1, e2, 
g = 30, h=90, 
rad = radians(g), rotation=radians(h);
String sentence;
PFont font;
PImage img;
color  colour1= color(255, 68, 0, 200), //background upper gradient 
colour2= color(255, 0, 0, 200);
void setup() {
  //background(255);
  //size( 7860, 4320);
  img = loadImage("Sketch29122137.jpg");
  size(  img.width, img.height );
  background(0);

  image(img, 0, 0);  setGradient(0, 0, img.width, img.height, colour1, colour2);
  blend(img, 0, 0, img.width, img.height, 0, 0, img.width, img.height, DARKEST);


  //  i=width/2;
  //  j=height/2;

  float i=img.width*.90;
  float j=img.height/2;//-img.width*.10;
  float y2=min(img.width, img.height)/5*sqrt(2);
  char[] letters = { 
    //  'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y', 
    //  5, 2, 4, 7, 3, 7, 7, 6, 9
    9, 6, 7, 7, 3, 7, 4, 2, 5
  };

  int o=18;
  a=y2/10/exp(b*(t2+o/2*rad));
  int no=0;
  b1=i+n*cos(rad);
  b2=j+n*sin(rad);

  a1=i-n*cos(rad);
  a2=j+n*sin(rad);
  t2=rad;

  noStroke();
  {
    //fill(color(0, 0, 0, 100));
    // ellipse(i, j, 3*a*exp(b*(t2+o*rad)), 3*a*exp(b*(t2+o*rad)));
    for (; o>0; o--)
    {
      //line(a1, a2, b1, b2);
      fill(color(0, 0, 0, 150));
      a1=b1;
      a2=b2;
      c1=i+a*exp(b*t2)*cos(t2);
      c2=j+a*exp(b*t2)*sin(t2);
      if (o%2==1)
      {  
        ellipse(c1, c2, a*exp(b*t2), a*exp(b*t2));

        sentence=""+int(letters[no++])+"";
        font=loadFont("AgencyFB-Bold-255.vlw");
        textFont(font, 0.7692*a*exp(b*t2));
        textAlign(CENTER, CENTER);
        fill(255, 255, 255);
        noSmooth();

        text(sentence, c1, c2);
      }
      t2+=rad;
      b1=c1;
      b2=c2;
    }
  }
  /*
  a1=i+n*cos(rad);
   a2=j+n*sin(rad);
   
   b1=i-n*cos(rad);
   b2=j+n*sin(rad);
   stroke(255);
   strokeWeight(40);
   point(i, j);
   strokeWeight(20);
   t2=rad;
   t1=rad+rotation;
   noStroke();
   for (int o=0; o<100; o+=3)
   {
   line(a1, a2, b1, b2);
   stroke(255);
   a1=b1;
   a2=b2;
   c1=i+a*exp(b*t2)*cos(t1);
   c2=j+a*exp(b*t2)*sin(t1);
   t1+=rad;
   t2+=rad;
   b1=c1;
   b2=c2;
   }
   
   a1=i+n*cos(rad);
   a2=j+n*sin(rad);
   
   b1=i-n*cos(rad);
   b2=j+n*sin(rad);
   stroke(255);
   strokeWeight(40);
   point(i, j);
   strokeWeight(20);
   t2=rad;
   t1=rad+rotation;
   noStroke();
   for (int o=0; o<100; o+=3)
   {
   line(a1, a2, b1, b2);
   stroke(255);
   a1=b1;
   a2=b2;
   c1=i+a*exp(b*t2)*cos(t1);
   c2=j+a*exp(b*t2)*sin(t1);
   t1+=rad;
   t2+=rad;
   b1=c1;
   b2=c2;
   }
   */
  save("diagonal3.tif");
}

void setGradient(int x, int y, float w, float h, color colour1, color colour2)
{


  noFill();

  {  // Top to bottom gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(colour1, colour2, inter);
      stroke(c);
      noSmooth();
      line(i, y, i, y+h);
    }
  }
}

void ip()
{
  a1=i+n*cos(rad);
  a2=j+n*sin(rad);

  b1=i-n*cos(rad);
  b2=j+n*sin(rad);
  stroke(255);
  strokeWeight(40);
  point(i, j);
  strokeWeight(20);
  t2=rad;
  t1=rad+rotation;
  noStroke();
  for (int o=0; o<100; o+=3)
  {
    line(a1, a2, b1, b2);
    stroke(255);
    a1=b1;
    a2=b2;
    c1=i+a*exp(b*t2)*cos(t1);
    c2=j+a*exp(b*t2)*sin(t1);
    t1+=rad;
    t2+=rad;
    b1=c1;
    b2=c2;
  }
}

