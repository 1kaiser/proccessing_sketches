int i, // x axis 
j, //y axis 
o, m; // important parameter for control of propagating triangles 


float 
n=200, // central circle radius 
b=1.2, // tightness of curve 
t1, t2, a1, a2, b1, b2, c11, c22, c1, c2, d1, d2, e1, e2, 
g = .09, 
rad = radians(g);


float h1=30;
float s1=200;

float a=s1*sin(h1/2);
float n1=.6, n2=.3;


void setup() {
  //background(240);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
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
    ellipse(n1*width, n2*height, 2*n, 2*n);//central circle
  }


  strokeWeight(4);
  fill(100, 0, 255, 120);
  noStroke();
  n=60;
  t2=rad;
  b=1.2;
  n=60;
  single_petal();
  b=1.2;
  n=-60;
  single_petal();
  b=1.2;
  n=30;
  single_petal();
  b=1.2;
  n=-30;
  single_petal();
  b=1.2;
  n=0;
  single_petal();
  fill(245, 245, 220);

  ellipse(n1*width, n2*height, 2*200, 2*200);//central circle
  fill(255, 0, 0, 180);
  noStroke();
  ellipse(n1*width, n2*height, 2*150, 2*150);



  icolour1=color(0, 255, 180);
  icolour2=color(0, 180, 255);
  float rad=.5*height;

  for (n=180; n>0; n=n-.1)
  {


    noSmooth();
    noFill();
    stroke(255);
    strokeWeight(20);
    arc(n1*width, n2*height, rad-30, rad-30, PI/2-PI/2 -radians(n), PI/2-PI/2+radians(n), OPEN);
    stroke(0);
    strokeWeight(2);
    arc(n1*width, n2*height, rad+90, rad+90, PI/2-PI/2 -radians(n), PI/2-PI/2+radians(n), OPEN);
    stroke(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    strokeWeight(20);
    arc(n1*width, n2*height, rad, rad, PI/2-PI/2 -radians(n), PI/2-PI/2+radians(n), OPEN);

    // rotation++;
  }
  save("diagonal1.png");
}
void single_petal()
{
  beginShape();

  for (int o=0; o<1000; o++)
  {
    c1=n1*width+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI/2);
    c2=n2*height+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI/2);
    t2+=rad;
    curveVertex(c1, c2);
  }

  for (int o=0; o<1000; o++)
  {
    c1=n1*width+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI/2);
    c2=n2*height+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI/2);
    t2-=rad;
    curveVertex(c1, c2);
  }
  b=.2;
  {
    for (int o=0; o<1000; o++)
    {
      c1=n1*width+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI/2);
      c2=n2*height+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI/2);
      t2+=rad;
      curveVertex(c1, c2);
    }
    for (int o=0; o<1000; o++)
    { 
      c1=n1*width+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI/2);
      c2=n2*height+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI/2);
      t2-=rad;
      curveVertex(c1, c2);
    }
  }
  endShape(CLOSE);
}

