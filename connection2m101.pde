int i, j;

float  ang1=0, n, cal;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/

float n1, n2;

PImage img;


void setup() {
  //size( 7860, 4320);
  //size( 8192, 5120);
  //background(50);

  img = loadImage("b.jpg");

  size( img.width*3, img.height*3);
  image(img, 0, 0, width, height);
  filter(GRAY);
  //background(img);
  noSmooth();
  c_centre();





  n1=.5; 
  n2=.5;
  color icolour2=color(255, 60, 200);
  color icolour1=color(255, 200, 60);
  /*
  for (n=0; n<1.1*dist (0, 0, width, height); n+=1)
   {
   
   stroke(lerpColor(icolour1, icolour2, map(n, 0, 1.1*dist (0, 0, width, height), 0, 1)));
   strokeWeight(2);
   noFill();
   noSmooth();
   ellipse(n1*width, n2*height, 2*n, 2*n);//central circle
   }
   
   
   icolour1=color(0, 255, 130);
   icolour2=color(0, 130, 255);
   color icolour3=color(255, 0, 255);
   color icolour4=color(255, 0, 130);
   
   
   float y11=min(width, height)/5;
   
   float s1=y11;
   noFill();
   stroke(60, 0, 255);
   strokeWeight(min(width, height)/150); 
   strokeJoin(MITER);
   noSmooth();
   //beginShape();
   for (float n=0; n<360; n=n+90)
   {
   float a1=n1*width+s1*cos(3*PI/2+radians(n));
   float a2=n2*height+s1*sin(3*PI/2+radians(n));
   ellipse(a1, a2, 2*s1, 2*s1);
   // vertex(a1, a2);///
   }
   // endShape(CLOSE);*/
  n1=.5; 
  n2=.4;

  icolour1=color(255);
  icolour2=color(255);
  color icolour3=color(255);
  color icolour4=color(255);
  float rad=min(width, height)*.3;


  float s1=rad/4;
  for ( n=0+30+180; n<120+30+180; n=n+120)
  {
    float a1=n1*width+s1*cos(radians(n));
    float a2=n2*height+s1*sin(radians(n));

    float b1=n1*width+s1*cos(radians(n+120));
    float b2=n2*height+s1*sin(radians(n+120));
    float c1=n1*width+s1*cos(radians(n+240));
    float c2=n2*height+s1*sin(radians(n+240));    



    for (float v=90; v>0; v=v-.1)
    {

      strokeWeight(min(width, height)/100);
      noSmooth();
      noFill();
      stroke(lerpColor(icolour1, icolour2, map(v, 0, 180, 0, 1)));
      arc(b1, b2, rad, rad, PI/2-radians(v)+radians(60), PI/2+radians(v)+radians(60), OPEN);
      stroke(lerpColor(icolour2, icolour3, map(v, 0, 180, 0, 1)));
      arc(a1, a2, rad, rad, PI/2-radians(v)+radians(-60), PI/2+radians(v)+radians(-60), OPEN);
      stroke(lerpColor(icolour3, icolour4, map(v, 0, 180, 0, 1)));
      arc(c1, c2, rad, rad, PI/2-radians(v)+radians(180), PI/2+radians(v)+radians(180), OPEN);
      // rotation++;
    }
  }


  n1=.5; 
  n2=.7;

  sentence=" GOD BLESS YOU ";
  cal=1;
  SENT();
  //font=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  //textFont(font, dist(0, 0, width, height)/20);
  //  textAlign(CENTER, BOTTOM );
  //fill(255);
  //  text(sentence, width*n1, height*n2);
  //


  //save("diagonal10.tif");
  save("e1.jpeg");
  save("e1.png");
  //save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

void heart(float q1, float q2)
{
  color icolour1=color(255, 0, 100);
  color icolour2=color(255, 0, 0);
  float p=2*min(width, height)/20;
  float s=p/sqrt(2);
  noSmooth();
  noStroke();
  fill(255, 0, 0);
  quad(q1, q2-s, q1+s, q2, q1, q2+s, q1-s, q2);
  for (float v=90; v>0; v=v-.1)
  {

    noStroke();
    noSmooth();
    fill(lerpColor(icolour1, icolour2, map(v, 0, 90, 0, 1)));
    arc(q1-s/2, q2-s/2, p, p, PI+PI/4-radians(v), PI+PI/4+radians(v), OPEN);
    arc(q1+s/2, q2-s/2, p, p, -PI/4-radians(v), -PI/4+radians(v), OPEN);
  }
}
void SENT()
{

  int no=0;
  float y0=2*min(width, height)/30;


  for (float y1=-1; y1<2; y1+=1)
  {

    for (float x1=-2; x1<3; x1+=1)

    { 



      // sentence=""+(++letters[no])+"";

      noSmooth();

      /*
      if (no==1) 
       {
       font=loadFont("AgencyFB-Bold-255.vlw");
       textFont(font, min(width, height)/20);
       textAlign(CENTER, CENTER);
       fill(255, 0, 0);
       int pos=0;
       for (float z1=-1.5; z1<2; z1+=1)
       {
       for (float z2=0; z2<1; z2+=1)
       { 
       String   sentence1="LOVE";
       text(sentence1.charAt(pos), n1*width+x1*y0+z2*150, n2*height+y1*y0+z1*150);
       pos++;
       }
       }
       }
       */
      PFont font=loadFont("AgencyFB-Bold-255.vlw");//AgencyFB-Bold-255.vlw");
      textFont(font, min(width, height)/20);
      textAlign(CENTER, CENTER);
      if (cal==0 || cal==1)
      {
        fill(10);//255, 215, 0);//255, 215, 0);

        if (no==12 ) 
        {
          float y11=min(width, height)/40;

          float s1=y11;
          noFill();
          stroke(255, 50, 50);
          strokeWeight(min(width, height)/200); 
          strokeJoin(MITER);
          noSmooth();
          beginShape();
          for (float n=60; n<360; n=n+120)
          {
            float a1=n1*width+x1*y0+s1*cos(3*PI/2+radians(n));
            float a2=n2*height+y1*y0+s1*sin(3*PI/2+radians(n))+min(width, height)/20;
            //ellipse(a1, a2, 2*s1, 2*s1);
            vertex(a1, a2);///
          }
          endShape(CLOSE);
        }
      }
      if (cal==0)
      {
        if (no<3 && no>=0 ) 
        {
          fill(255, 0, 0);
        }
      }
      text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
      no++;
    }
  }
}

