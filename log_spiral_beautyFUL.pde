int i, // x axis 
j, //y axis 
o, m; // important parameter for control of propagating triangles 


float 
n=200, // central circle radius 
b=0.4, // tightness of curve 
t1, t2, a1, a2, b1, b2, c11, c22, c1, c2, d1, d2, e1, e2, 
g = .09, 
rad = radians(g);



void setup() {
  background(255);
  size( 7860, 4320);


  float n1=.5, n2=.5;
  i=width/2;
  j=height/2;

  float h1=30;
  float s1=500;

  float a=s1*sin(h1/2);

  stroke(0);
  strokeWeight(40);
  point(i, j);
  strokeWeight(2);
  strokeJoin(MITER);
  //noFill();
  noStroke();
  noSmooth();

  t2=rad;

  fill(255, 50, 50, 150);
  for (float n=h1/2; n<360; n=n+h1)
  {
    beginShape();

    for (int o=0; o<1000; o++)
    {
      c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
      c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);
      t2+=rad;
      curveVertex(c1, c2);
    }

    for (int o=0; o<1000; o++)
    {
      c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
      c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
      t2-=rad;
      curveVertex(c1, c2);
    }
    endShape(CLOSE);
  }

  color icolour1=color(255, 255, 0);
  color icolour2=color(255, 150, 0);

  for (n=180; n>0; n=n-.1)
  {
    noStroke();
    fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    // strokeWeight(50);
    noSmooth();
    arc(n1*width, n2*height, 3*s1, 3*s1, 2*PI-PI/2 -radians(n), 2*PI-PI/2+radians(n), OPEN);
    // rotation++;
  }

  save("diagonal1.png");
}

