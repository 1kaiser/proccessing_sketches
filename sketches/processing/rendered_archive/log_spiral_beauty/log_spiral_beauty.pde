int i, // x axis 
j, //y axis 
o, m; // important parameter for control of propagating triangles 


float 
n=200, // central circle radius 
b=0.2, // tightness of curve 
t1, t2, a1, a2, b1, b2, c11, c22, c1, c2, d1, d2, e1, e2, 
g = .09, h=45, 
rad = radians(g), rotation=radians(h);



void setup() {
  //background(220);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);



  i=width/2;
  j=height/2;

  float h1=30;
  float s1=500;
  float   l=sqrt(3)*s1*tan(radians(h/2));
  float a=2*s1*sin(h1/2);

  stroke(0);
  strokeWeight(40);
  point(i, j);
  strokeWeight(2);
  strokeJoin(MITER);
  //noFill();

  noSmooth();
  fill(255, 0, 0, 200);
  t2=rad;
  for (float n=h1/2; n<360; n=n+h1)
  {
    beginShape();

    for (int o=0; o<1000; o++)
    {
      c1=width/2+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
      c2=height/2+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);
      t2+=rad;
      curveVertex(c1, c2);
    }

    for (int o=0; o<1000; o++)
    {
      c1=width/2+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
      c2=height/2+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
      t2-=rad;
      curveVertex(c1, c2);
    }
    endShape(CLOSE);
  }

  save("diagonal1.png");
}

