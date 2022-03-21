int l=100, p=500, c1=1, i1=5, i2;
float a=1, b=100, i, k, j=20, m1=0, m2=0, m3;
float inc = radians(15), re=radians(30);
String  sentence="5";
PFont font1;
color c;
PImage img;


void setup() {
  //size( 7860, 4320);
  //size( 8192, 5120);
  //background(50);

  img = loadImage("c (1).jpg");
  int ll=2;
  size( img.width*ll, img.height*ll);
  image(img, 0, 0, width, height);
  filter(GRAY);
  filter(POSTERIZE, 50);/*
  noSmooth();
   
   float n1=.5, n2=.4;
   float y11=min(width, height)/5;
   
   float s1=y11/sqrt(2);
   noFill();
   stroke(255);
   strokeWeight(min(width, height)/300);
   //ellipse(n1*width, n2*height, s1*2, s1*2);
   noStroke();
   fill(0);
   rect(width*.05, height*0, width*.5-2*width*.025, height-2* height*0);
   
   sentence="Alfred, Lord Tennyson\nulysses\n\n\n“we are not now that strength which in old days moved earth and heaven\nthat which we are, we are\none equal temper of heroic hearts, made weak by time and fate, but strong in will\nto strive, to seek, to find, and not to yield.” ";
   font1=loadFont("LHFOldBlockCondBold-255.vlw");
   //font1=loadFont("AgencyFB-Bold-255.vlw");
   textFont(font1, min(width, height)/40);
   textAlign(CENTER, CENTER);
   
   noSmooth();
   n1=.5;
   n2=.7;
   noStroke();
   fill(0, 150);
   rect(width*.05, height*.6, width*1-2*width*.05, height-2* height*.4);
   fill(255);
   text(sentence, n1*width, n2*height);
   
   n1=.275;
   n2=.35;
   
   char[] letters = { 
   'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y', 
   5, 2, 4, 7, 3, 7, 7, 6, 9
   };
   int[] num = { 
   5, 2, 4, 7, 3, 7, 7, 6, 9
   };
   
   PFont font=loadFont("AgencyFB-Bold-255.vlw");
   textFont(font, min(width, height)/12);
   noSmooth();
   int no=0;
   float y0=2*min(width, height)/12;
   
   for (float y1=-y0; y1<=y0; y1+=y0)
   {
   for (float x1=-y0; x1<=y0; x1+=y0)
   
   { 
   sentence=""+(num[no])+"";
   fill(0, 255, 185);
   if (no>5)
   {
   textFont(font, min(width, height)/12);
   fill(255, 215, 0);
   }
   if (y1==x1)
   {
   sentence=""+(letters[no])+"";
   fill(255, 255, 255);
   }
   textAlign(CENTER, CENTER);
   text(sentence, n1*width+x1, n2*height+y1);
   no++;
   }
   }
   */

  // save("sat11.jpeg");
  save("sat11X2207474.png");
}



void petals(float n1, float n2, float s1)
{
  int i, // x axis 
  j, //y axis 
  m; // important parameter for control of propagating triangles 


  float 
    // n=200, // central circle radius 
  b=1.2, // tightness of curve 
  t1, t2, a1, a2, b1, b2, c11, c22, c1, c2, d1, d2, e1, e2, f1, f2, 
  g = .09, 
  rad = radians(g);
  t2 = radians(g);


  float h1=30;


  float a=s1*sin(h1/2)/3*2;



  for (float n=h1/2; n<360; n=n+h1)
  { 
    beginShape();
    b=.2;
    for (int o=0; o<1000; o++)    
    {
      c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
      c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);
      t2+=rad;
      vertex(c1, c2);
    }

    for (int o=0; o<1000; o++)
    {
      c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
      c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
      t2-=rad;
      vertex(c1, c2);
    }
    b=0;
    {
      for (int o=0; o<1000; o++)
      {      
        c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
        c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
        t2+=rad;
        vertex(c1, c2);
      }
      for (int o=0; o<1000; o++)
      {
        c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
        c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);

        t2-=rad;
        vertex(c1, c2);
      }
    }
    endShape(CLOSE);
  }
}

