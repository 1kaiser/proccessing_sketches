int i, // x axis 
j, //y axis 
o, m; // important parameter for control of propagating triangles 


float 
n=200, // central circle radius 
a=n, //radius of curve 
b=1.2, // tightness of curve 
t1, t2, a1, a2, b1, b2, c11, c22, c1, c2, d1, d2, e1, e2, 
g = .09, 
rad = radians(g);



void setup() {
  background(255);
  size( 7860, 4320);
  stroke(255);
  strokeWeight(10);

  i=width/2;
  j=height/2;


  strokeWeight(20);
  fill(255, 130, 0, 100);
  noStroke();


  float h1=60;
  float s1=100;

  float a=s1*sin(h1/2);
  float n1=.5, n2=.5;
  for (float n=0+270+h1; n<270+270+h1; n=n+h1)
  {
    t2=rad;
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
  save("diagonal1.png");
}

