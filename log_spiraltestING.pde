int i, // x axis 
j, //y axis 
o, m; // important parameter for control of propagating triangles 


float 
n=200, // central circle radius 
b=1.2, // tightness of curve 
t1, t2, a1, a2, b1, b2, c11, c22, c1, c2, d1, d2, e1, e2, f1, f2, 
g = .09, 
rad = radians(g);

color icolour2=color(150, 150, 150);
color icolour1=color(255, 255, 255);

float h1=30;
float s1=500;

float a=s1*sin(h1/2)/3;
float n1=.7, n2=.3;


void setup() {
  background(255);
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
    fill(255, 128, 0, 200);
    petals();
  }

  icolour1=color(0, 0, 255);
  icolour2=color(0, 0, 128);

  for (n=0; n<3/2*s1; n+=1)
  {

    stroke(lerpColor(icolour1, icolour2, map(n, 0, 3/2*s1, 0, 1)));
    strokeWeight(1);
    noFill();
    smooth();
    ellipse(n1*width, n2*height, 2*n, 2*n);//central circle
  }
  stroke(0, 0, 128);
  strokeWeight(50);
  for (float n=0; n<360; n=n+h1/4)
  {

    //for (int o=0; o<1000; o++)
    {
      c1=n1*width+s1*cos(radians(n));//+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
      c2=n2*height+s1*sin(radians(n));//+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);

      point(c1, c2);
    }
  }
  noStroke();
  fill(255, 120, 120);
  noSmooth();
  ellipse(n1*width, n2*height, 2*s1-100, 2*s1-100);//central circle

  n1=.5; 
  n2=.4;

  String sentence="TAKEYOURBESTSTEP";

  int no=0;
  float y0=2*min(width, height)/30;

  for (float y1=-1.5; y1<2; y1+=1)
  {

    for (float x1=-1.5; x1<2; x1+=1)

    { 



      // sentence=""+(++letters[no])+"";

      noSmooth();

      /*
      if (no==6) 
       {
       font=loadFont("AgencyFB-Bold-255.vlw");
       textFont(font, 150);
       textAlign(CENTER, CENTER);
       fill(255, 255, 0);
       int pos=0;
       for (float z1=-1.5; z1<2; z1+=1)
       {
       for (float z2=0; z2<1; z2+=1)
       { 
       String   sentence1="ZERO";
       text(sentence1.charAt(pos), n1*width+x1*y0+z2*150, n2*height+y1*y0+z1*150);
       pos++;
       }
       }
       }
       */
      PFont font=loadFont("HelveticaNeue-CondensedBold-255.vlw");//AgencyFB-Bold-255.vlw");
      textFont(font, min(width, height)/20);
      textAlign(CENTER, CENTER);
      fill(0, 160, 255, 180);//255, 215, 0);
      if (no<8&& no>=0 ) 
      {
        fill(50, 50, 50, 200);
      }
      if (no>=8) 
      {
        fill(10, 10, 10, 200);
      }
      text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
      no++;
    }
  }
  float y11=min(width, height)/4;

  float s1=y11;
  noFill();
  stroke(33, 133, 89, 180);
  strokeWeight(min(width, height)/80); 
  strokeJoin(MITER);
  noSmooth();
  beginShape();
  for (float n=45; n<360; n=n+90)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    vertex(a1, a2);///
  }
  endShape(CLOSE);

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

      curveVertex(c1, c2);
      t2+=rad;
    }
    for (int o=0; o<1000; o++)
    {
      c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
      c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
      curveVertex(c1, c2);
      t2-=rad;
    }
    endShape(CLOSE);
  }
}

