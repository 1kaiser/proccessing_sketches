int i, j;

float  ang1=0, ang2, tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  //background(255, 255, 255, 255);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  c_centre();
  icolour1=color(0, 0, 0, 100);
  icolour2=color(0, 0, 0);


  float y11=.4*height;//min(width, height)/2;
  float n1=.5, n2=.5;

  stroke(255, 0, 0);
  noSmooth();
  noFill();
  float h=10;
  float s1=y11/2;
  float l=5*s1*tan(radians(h/2));
  for (n=10; n<360; n=n+h)
  {

    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+(s1+l)*cos(3*PI/2+radians(n+h/2));
    float b2=n2*height+(s1+l)*sin(3*PI/2+radians(n+h/2));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+h));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+h));
    float d1=n1*width+s1*cos(3*PI/2+radians(n+h/2));
    float d2=n2*height+s1*sin(3*PI/2+radians(n+h/2));
    noStroke();
    float f1=n1*width+(s1+l*1.4)*cos(3*PI/2+radians(n+h/2));
    float f2=n2*height+(s1+l*1.4)*sin(3*PI/2+radians(n+h/2));
    fill(180, 180, 180);
    quad(a1, a2, f1, f2, c1, c2, d1, d2);///
    float e1=n1*width+(s1+l*1.2)*cos(3*PI/2+radians(n+h/2));
    float e2=n2*height+(s1+l*1.2)*sin(3*PI/2+radians(n+h/2));
    fill(200, 200, 200);
    quad(a1, a2, e1, e2, c1, c2, d1, d2);///
    fill(255, 255, 255);
    noSmooth();
    quad(a1, a2, b1, b2, c1, c2, d1, d2);///
  }
  l=5*s1*tan(radians(h/2));
  for (n=8; n<360; n=n+h)
  {

    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+(s1+l)*cos(3*PI/2+radians(n+h/2));
    float b2=n2*height+(s1+l)*sin(3*PI/2+radians(n+h/2));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+h));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+h));
    float d1=n1*width+s1*cos(3*PI/2+radians(n+h/2));
    float d2=n2*height+s1*sin(3*PI/2+radians(n+h/2));
    noStroke();
    float f1=n1*width+(s1+l*1.4)*cos(3*PI/2+radians(n+h/2));
    float f2=n2*height+(s1+l*1.4)*sin(3*PI/2+radians(n+h/2));
    fill(180, 180, 180);
    quad(a1, a2, f1, f2, c1, c2, d1, d2);///
    float e1=n1*width+(s1+l*1.2)*cos(3*PI/2+radians(n+h/2));
    float e2=n2*height+(s1+l*1.2)*sin(3*PI/2+radians(n+h/2));
    fill(200, 200, 200);
    quad(a1, a2, e1, e2, c1, c2, d1, d2);///
    fill(255, 255, 255);
    noSmooth();
    quad(a1, a2, b1, b2, c1, c2, d1, d2);///
  }
  l=4*s1*tan(radians(h/2));
  for (n=6; n<360; n=n+h)
  {

    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+(s1+l)*cos(3*PI/2+radians(n+h/2));
    float b2=n2*height+(s1+l)*sin(3*PI/2+radians(n+h/2));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+h));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+h));
    float d1=n1*width+s1*cos(3*PI/2+radians(n+h/2));
    float d2=n2*height+s1*sin(3*PI/2+radians(n+h/2));
    noStroke();
    float f1=n1*width+(s1+l*1.4)*cos(3*PI/2+radians(n+h/2));
    float f2=n2*height+(s1+l*1.4)*sin(3*PI/2+radians(n+h/2));
    fill(180, 180, 180);
    quad(a1, a2, f1, f2, c1, c2, d1, d2);///
    float e1=n1*width+(s1+l*1.2)*cos(3*PI/2+radians(n+h/2));
    float e2=n2*height+(s1+l*1.2)*sin(3*PI/2+radians(n+h/2));
    fill(200, 200, 200);
    quad(a1, a2, e1, e2, c1, c2, d1, d2);///
    fill(255, 255, 255);
    noSmooth();
    quad(a1, a2, b1, b2, c1, c2, d1, d2);///
  }
  l=3*s1*tan(radians(h/2));
  for (n=4; n<360; n=n+h)
  {

    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+(s1+l)*cos(3*PI/2+radians(n+h/2));
    float b2=n2*height+(s1+l)*sin(3*PI/2+radians(n+h/2));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+h));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+h));
    float d1=n1*width+s1*cos(3*PI/2+radians(n+h/2));
    float d2=n2*height+s1*sin(3*PI/2+radians(n+h/2));
    noStroke();
    float f1=n1*width+(s1+l*1.4)*cos(3*PI/2+radians(n+h/2));
    float f2=n2*height+(s1+l*1.4)*sin(3*PI/2+radians(n+h/2));
    fill(180, 180, 180);
    quad(a1, a2, f1, f2, c1, c2, d1, d2);///
    float e1=n1*width+(s1+l*1.2)*cos(3*PI/2+radians(n+h/2));
    float e2=n2*height+(s1+l*1.2)*sin(3*PI/2+radians(n+h/2));
    fill(200, 200, 200);
    quad(a1, a2, e1, e2, c1, c2, d1, d2);///
    fill(255, 255, 255);
    noSmooth();
    quad(a1, a2, b1, b2, c1, c2, d1, d2);///
  }
  l=2*s1*tan(radians(h/2));
  for (n=2; n<360; n=n+h)
  {

    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+(s1+l)*cos(3*PI/2+radians(n+h/2));
    float b2=n2*height+(s1+l)*sin(3*PI/2+radians(n+h/2));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+h));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+h));
    float d1=n1*width+s1*cos(3*PI/2+radians(n+h/2));
    float d2=n2*height+s1*sin(3*PI/2+radians(n+h/2));
    noStroke();
    float f1=n1*width+(s1+l*1.4)*cos(3*PI/2+radians(n+h/2));
    float f2=n2*height+(s1+l*1.4)*sin(3*PI/2+radians(n+h/2));
    fill(180, 180, 180);
    quad(a1, a2, f1, f2, c1, c2, d1, d2);///
    float e1=n1*width+(s1+l*1.2)*cos(3*PI/2+radians(n+h/2));
    float e2=n2*height+(s1+l*1.2)*sin(3*PI/2+radians(n+h/2));
    fill(200, 200, 200);
    quad(a1, a2, e1, e2, c1, c2, d1, d2);///
    fill(255, 255, 255);
    noSmooth();
    quad(a1, a2, b1, b2, c1, c2, d1, d2);///
  }
  l=s1*tan(radians(h/2));
  for (n=0; n<360; n=n+h)
  {

    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+(s1+l)*cos(3*PI/2+radians(n+h/2));
    float b2=n2*height+(s1+l)*sin(3*PI/2+radians(n+h/2));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+h));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+h));
    float d1=n1*width+s1*cos(3*PI/2+radians(n+h/2));
    float d2=n2*height+s1*sin(3*PI/2+radians(n+h/2));
    noStroke();
    float f1=n1*width+(s1+l*1.4)*cos(3*PI/2+radians(n+h/2));
    float f2=n2*height+(s1+l*1.4)*sin(3*PI/2+radians(n+h/2));
    fill(180, 180, 180);
    quad(a1, a2, f1, f2, c1, c2, d1, d2);///
    float e1=n1*width+(s1+l*1.2)*cos(3*PI/2+radians(n+h/2));
    float e2=n2*height+(s1+l*1.2)*sin(3*PI/2+radians(n+h/2));
    fill(200, 200, 200);
    quad(a1, a2, e1, e2, c1, c2, d1, d2);///
    fill(255, 255, 255);
    noSmooth();
    quad(a1, a2, b1, b2, c1, c2, d1, d2);///
  }

  icolour1=color(255, 0, 255);
  icolour2=color(0, 255, 255);

  for (n=180; n>0; n=n-.1)
  {
    noStroke();
    fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    // strokeWeight(50);
    noSmooth();
    arc(i, j, .4*height, .4*height, 2*PI-PI/4-PI/2 -radians(n), 2*PI-PI/4-PI/2+radians(n), OPEN);
    // rotation++;
  }
  //save("diagonal10.tif");
  save("diagonal14.png");
  //save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

