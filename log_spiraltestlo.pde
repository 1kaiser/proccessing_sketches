int i, // x axis 
j, //y axis 
o, m; // important parameter for control of propagating triangles 


float 
n=200, // central circle radius 
b=1.2, // tightness of curve 
t1, t2, a1, a2, b1, b2, c11, c22, c1, c2, d1, d2, e1, e2, 
g = .09, 
rad = radians(g);


float h1=15;
float s1=500;

float a=s1*sin(h1/2);
float n1=.7, n2=.6;


void setup() {
  background(255, 255, 255, 50);
  size( 7860, 4320);



  i=width/2;
  j=height/2;


  strokeWeight(20);
  strokeJoin(MITER);
  //noFill();
  noStroke();
  noSmooth();

  t2=rad;
  {
    b=1;
    fill(255, 0, 130, 20);
    petals();
    n1=.4; 
    n2=.9;
    b=.6;
    fill(255, 0, 130, 40);
    petals();
  }

  //  (150, 75, 0)

  save("diagonal1.png");
}


void petals()
{
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
}

