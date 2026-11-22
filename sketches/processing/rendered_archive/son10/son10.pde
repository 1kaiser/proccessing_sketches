int l=100, p=500, c1=1, i1=5, i2;
float a=1, b=100, i, k, j=20, m1=0, m2=0, m3;
float inc = radians(15), re=radians(30);
String  sentence="5";
//PFont //font1;
color c;
//PImage //img;


void setup() {
  //size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  //size( 7860/3, 4320/3);//size( 8192/3, 5120/3);
  ////background(50);

  //img = loadImage("X (4).jpg");
  int ll=2;
  size( 7860/3, 4320/3);//size( 7860*ll, 4320*ll);
  //image(//img, 0, 0, width, height);
  filter(GRAY);
  filter(POSTERIZE, 20);
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
  rect(width*.5, height*0, width*.5-2*width*.025, height-2* height*0);
  /*
  n1=.25; 
   n2=.9;
   
   noFill();
   stroke(255);
   strokeWeight(min(width, height)/300);
   ellipse(n1*width, n2*height, s1*2, s1*2);
   
   
   //icolour1=color(80, 0, 200);
   //icolour2=color(50, 0, 110);
   color icolour1=color(255, 40, 60);
   color icolour2=color(255, 80, 30);
   color icolour3=color(0, 255, 0);
   color icolour4=color(0, 255, 255);
   for (float n=180; n>0; n=n-.1)
   {
   noStroke();
   //fill(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
   // strokeWeight(50);
   noSmooth();
   //arc(n1*width-s1, n2*height, s1/1.6, s1/1.6, PI/2 -radians(n), PI/2+radians(n), OPEN);
   fill(lerpColor(icolour3, icolour4, map(n, 0, 180, 0, 1)));
   arc(n1*width+s1, n2*height, s1*.8, s1*.8, PI/2 -radians(n), PI/2+radians(n), OPEN);
   // rotation++;
   }
   
   fill(255, 0, 0);
   petals(n1, n2, y11/3+y11*.01);
   y11=min(width, height)/20;
   
   s1=y11;
   for (float n=0; n<120; n=n+120)
   {
   float a1=n1*width+s1*cos(3*PI/2+radians(n));
   float a2=n2*height+s1*sin(3*PI/2+radians(n));
   
   float b1=n1*width+s1*cos(3*PI/2+radians(n+120));
   float b2=n2*height+s1*sin(3*PI/2+radians(n+120));
   float c1=n1*width+s1*cos(3*PI/2+radians(n+240));
   float c2=n2*height+s1*sin(3*PI/2+radians(n+240));
   noFill();
   stroke(color(100, 0, 180));
   strokeWeight(min(width, height)/120); 
   strokeJoin(MITER);
   noSmooth();
   triangle(a1, a2, b1, b2, c1, c2);///
   }
   */
  sentence="Sajna de ba jo main te\nJike hun ki karna rabba\n\nHaathon ki Kismat Ka \nKoi jaane Na maane\nYe saath hai kitnaa Haseen\n\nkash ye pal tham jaaye\nAap ke hum ban jaaye\nJannat bhulake hum teri\nAankhon ke ashq ban jaaye ";
  //font1=loadFont("MVBoli-255.vlw");
  ////font1=loadFont("AgencyFB-Bold-255.vlw");
  //textFont(//font1, min(width, height)/30);
  textAlign(CENTER, CENTER);
  fill(0);
  noSmooth();
  n1=.725;
  n2=.5;

  char[] letters = { 
    'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y', 
    5, 2, 4, 7, 3, 7, 7, 6, 9
  };
  int[] num = { 
    5, 2, 4, 7, 3, 7, 7, 6, 9
  };

  //PFont //font=loadFont("AgencyFB-Bold-255.vlw");
  //textFont(//font, min(width, height)/12);
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
        //textFont(//font, min(width, height)/12);
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


  // save("sat11.jpeg");
  save("sat11X15.png");
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

