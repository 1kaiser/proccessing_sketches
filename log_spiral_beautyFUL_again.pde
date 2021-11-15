int i, // x axis 
j, //y axis 
o, m; // important parameter for control of propagating triangles 


float 
n=200, // central circle radius 
b=0.3, // tightness of curve 
t1, t2, a1, a2, b1, b2, c11, c22, c1, c2, d1, d2, e1, e2, 
g = .09, 
rad = radians(g);

float h1=15;
float s1=500;

float a=s1*sin(h1/2);
float n1=.5, n2=.5;


void setup() {
  background(10);
  size( 7860, 4320);



  i=width/2;
  j=height/2;



  stroke(0);
  strokeWeight(40);
  point(i, j);
  strokeWeight(2);
  strokeJoin(MITER);
  //noFill();
  noStroke();
  noSmooth();

  t2=rad;
  {
    b=.8;
    fill(255, 0, 0, 80);
    petals();
    b=.5;
    fill(255, 130, 0, 90);
    petals();
    b=.3;
    fill(255, 255, 0, 50);
    petals();
  }
  color icolour1=color(130, 0, 255);
  color icolour2=color(0, 255, 130);

  for (n=180; n>0; n=n-.1)
  {
    noStroke();
    fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    // strokeWeight(50);
    noSmooth();
    arc(n1*width, n2*height, 3*s1, 3*s1, 2*PI-PI/4-PI/2 -radians(n), 2*PI-PI/4-PI/2+radians(n), OPEN);

    // rotation++;
  }
  noFill();
  stroke(255);
  strokeWeight(8);
  ellipse(n1*width, n2*height, 3*s1-50, 3*s1-50);


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

