int i, // x axis 
j, //y axis 
o, m; // important parameter for control of propagating triangles 


float 
n=200, // central circle radius 
a=n, //radius of curve 
b=1.2, // tightness of curve 
t1, t2, a1, a2, b1, b2, c11, c22, c1, c2, d1, d2, e1, e2, 
g = .09, h=45, 
rad = radians(g), rotation=radians(h);



void setup() {
  background(0);
  size( 7860, 4320);
  stroke(255);
  strokeWeight(10);

  i=width/2;
  j=height/2;


  stroke(255);
  strokeWeight(40);
  point(i, j);
  strokeWeight(20);
  strokeJoin(MITER);
  noFill();

  t2=rad;
  beginShape(TRIANGLE_STRIP);

  for (int o=0; o<1000; o++)
  {
    c1=i+a*exp(b*t2)*cos(t2+PI/2+PI/2);
    c2=j+a*exp(b*t2)*sin(t2+PI/2+PI/2);
    t2+=rad;
    vertex(c1, c2);
  }

  for (int o=0; o<1000; o++)
  {
    c1=i+a*exp(b*t2)*cos(-t2-PI/2+PI/2);
    c2=j+a*exp(b*t2)*sin(-t2-PI/2+PI/2);
    t2-=rad;
    vertex(c1, c2);
  }
  endShape(CLOSE);


  save("diagonal1.png");
}

