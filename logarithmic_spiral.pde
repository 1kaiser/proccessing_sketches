int i, // x axis 
j, //y axis 
m; // important parameter for control of propagating triangles 


float 
n=100, // central circle radius 
a=n, //radius of curve 
b=.8, // tightness of curve 
t1, t2, a1, a2, b1, b2, c1, c2, d1, d2, e1, e2, 
g = .2, 
rad = radians(g);



void setup() {
  background(0);
  size(7860, 4320);
  stroke(255);
  strokeWeight(10);
  noFill();
  i=width/2;
  j=height/2;
  e1=i;
  e2=j;
  //left arc
  arc(i, j, 2*sqrt(2)*a, 2*sqrt(2)*a, PI-QUARTER_PI, PI+QUARTER_PI, CHORD);

  //right arc
  arc(i, j, 2*sqrt(2)*a, 2*sqrt(2)*a, TWO_PI-QUARTER_PI, TWO_PI+QUARTER_PI, CHORD);


  //upper interpolation 


  a1=i+n;
  a2=j-n;

  b1=i-n;
  b2=j-n;
  m=1;
  t1=m*rad;
  c1=i+a*exp(b*t1)*cos(t1);
  c2=j+a*exp(b*t1)*sin(t1);
  stroke(255);
  triangle(a1, a2, b1, b2, c1, c2);
  
  m=2;
  t1=m*rad;
  d1=i+a*exp(b*t1)*cos(t1);
  d2=j+a*exp(b*t1)*sin(t1);

  triangle(b1, b2, c1, c2, d1, d2);
 
 
 m=3;
 t1=m*rad;
 e1=i+a*exp(b*t1)*cos(t1);
    e2=j+a*exp(b*t1)*sin(t1);
    
    
    triangle(b1, b2, d1, d2, e1, e2);
   
   
  m=2;
  t1=PI+QUARTER_PI+m*rad;
  t2=TWO_PI-QUARTER_PI+m*rad;
  stroke(255);
  triangulating_logarithmic_curve_1(b1, b2, c1, c2);


  //lower interpolation 

  a1=i-n;
  a2=j+n;

  b1=i+n;
  b2=j+n;
  m=1;
  t1=QUARTER_PI-m*rad;
  c1=i+a*exp(b*t1)*cos(t1);
  c2=j+a*exp(b*t1)*sin(t1);
  stroke(255);
  triangle(a1, a2, b1, b2, c1, c2);

  m=2;
 // t1=QUARTER_PI+m*rad;
  //t2=PI-QUARTER_PI+m*rad;
  stroke(255);
  triangulating_logarithmic_curve_2(b1, b2, c1, c2);


  save("diagonal.tif");
  // noLoop();  // Run once and stop
}


void triangulating_logarithmic_curve_1(float b1, float  b2, float  c1, float  c2)
{
  d1=i+a*exp(b*t1)*cos(t1);
  d2=j+a*exp(b*t1)*sin(t1);

 // triangle(b1, b2, c1, c2, d1, d2);
  m--;
  if (c1<width||c2<height||c1>0||c2>0)
  {

    e1=i+a*exp(b*t1)*cos(t1);
    e2=j+a*exp(b*t1)*sin(t1);
    m+=2;
   // triangle(b1, b2, d1, d2, e1, e2);

  // triangulating_logarithmic_curve_1(  d1, d2, e1, e2 );
  }
}
void triangulating_logarithmic_curve_2(float b1, float  b2, float  c1, float  c2)
{t1=QUARTER_PI+m*rad;
  d1=i+a*exp(b*t1)*cos(t1);
  d2=j+a*exp(b*t1)*sin(t1);

 // triangle(b1, b2, c1, c2, d1, d2);
  m--;
  if (c1<width||c2<height||c1>0||c2>0)
  {
t2=PI-QUARTER_PI+m*rad;
    e1=i+a*exp(b*t1)*cos(t1);
    e2=j+a*exp(b*t1)*sin(t1);
    m+=2;
  // triangle(b1, b2, d1, d2, e1, e2);

   // triangulating_logarithmic_curve_2(  d1, d2, e1, e2 );
  }
}

