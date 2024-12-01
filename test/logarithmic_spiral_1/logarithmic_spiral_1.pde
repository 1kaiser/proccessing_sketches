int i, // x axis 
j, //y axis 
o, m, t; // important parameter for control of propagating triangles 
String sentence;
//PFont //font;

float 
n=250, // central circle radius 
a=n, //radius of curve 
b=1.8, // tightness of curve 
t1, t2, t3, a1, a2, b1, b2, c1, c2, d1, d2, e1, e2, 
g = 30, h=90, 
s= 45, 
rad = radians(g), rotation=radians(h), 
gap=radians(s);
color icolour, icolour1, icolour2;


void setup() {
  //background(255);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  c_centre();
  noSmooth();
  noStroke();
  {
    icolour1=color(51, 255, 255, 200);
    icolour2=color(51, 102, 255, 200);
    for (t=0; t<10; t+=2)
    {
      a1=i+n*cos(rad+t*gap);
      a2=j+n*sin(rad+t*gap);

      b1=i-n*cos(rad+t*gap);
      b2=j+n*sin(rad+t*gap);
      tls(a1, a2, b1, b2, t);
    }
  }

  stroke(0, 0, 128, 100);
  strokeWeight(1);
  noFill();
  noSmooth();
  for (n=0; n<a*sqrt (2); n++)
  {
    ellipse(i, j, 2*sqrt(2)*n, 2*sqrt(2)*n);//central circle
  }

  //font=loadFont("AgencyFB-Bold-255.vlw");
  //textFont(//font, sqrt(2)*500);
  textAlign(CENTER, CENTER);
  fill(255, 238, 51, 200);
  noSmooth();
  text("68", i, j);

  sentence="THINK ON YOUR SINS\n14.139.241.84\n";
  //font=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  //textFont(//font, 100);
  textAlign(CENTER, BOTTOM );
  fill(255);
  noSmooth();
  text(sentence, width/2, height);


  save("diagonal1.tif");
}
void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}
void tls(float a1, float a2, float b1, float b2, int m)//triangle in logarithmic spiral 
{
  t2=rad;
  t1=rad+m*rotation;//
  t3=rad+(m+1)*rotation;///
  for (int o=0; o<20; o++)
  {
    c1=i+a*exp(b*t2)*cos(t1);///
    c2=j+a*exp(b*t2)*sin(t1);///
    e1=(a1+ c1+ b1)/3;
    e2=(a2+ c2+ b2)/3;
    fill(lerpColor(icolour1, icolour2, map(dist(i, j, e1, e2), 0, dist(0, 0, i, j), 0, 1)));
    triangle(a1, a2, b1, b2, c1, c2);
    d1=i+a*exp(b*t2)*cos(t3);///
    d2=j+a*exp(b*t2)*sin(t3);///
    e1=(d1+ b1+ c1)/3;
    e2=(d2+ b2+ c2)/3;
    fill(lerpColor(icolour1, icolour2, map(dist(i, j, e1, e2), 0, dist(0, 0, i, j), 0, 1)));
    triangle(b1, b2, c1, c2, d1, d2);///
    a1=c1;///
    a2=c2;///

    b1=d1;///
    b2=d2;///

    t1+=rad;//
    t2+=rad;
    t3+=rad;///
  }
}

