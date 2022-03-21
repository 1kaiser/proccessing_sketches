int i, // x axis 
j, //y axis 
o, m; // important parameter for control of propagating triangles 


float 
n=200, // central circle radius 
b=1.2, // tightness of curve 
t1, t2, a1, a2, b1, b2, c11, c22, c1=0, c2=0, d1=1, d2=1, e1, e2, 
g = .09, 
rad = radians(g);


float h1=30;
float s1=300;

float a=s1*sin(h1/2);
float n1=.5, n2=.5;


void setup() {
  background(240);
  size( 7860, 4320);
  stroke(255);
  strokeWeight(10);

  i=width/2;
  j=height/2;



  color icolour2=color(150, 150, 150);
  color icolour1=color(255, 255, 255);

  for (n=0; n<1.1*dist (0, 0, width, height); n+=1)
  {

    stroke(lerpColor(icolour1, icolour2, map(n, 0, 1.1*dist (0, 0, width, height), 0, 1)));
    strokeWeight(2);
    noFill();
    noSmooth();
    ellipse(n1*width, n1*height, 2*n, 2*n);//central circle
  }

  stroke(255, 0, 0, 180);
  strokeWeight(400);
  point(n1*width, n1*height);
  strokeWeight(1);
  noFill();
  t2=rad;
  t1=t2;
  b=1.2;
  n=0;
  single_petal();

  save("diagonal1.png");
}
void single_petal()
{
  // beginShape();

  for (int o=0; o<1000; o++)
  {
    c1=n1*width+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI/2);
    c2=n2*height+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI/2);


    d1=n1*width+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI/2);
    d2=n2*height+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI/2);
    t2+=rad;
    line(c1, c2, d1, d2);
  }
}
// endShape(CLOSE);

