int i, j;

float  ang1=0, n, cal;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/

float n1, n2;


void setup() 
{
  background(255);
  size( 7860, 4320);
  c_centre();





  n1=.5; 
  n2=.5;
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






  sentence="I_U";
  cal=1;
  SENT();




  //save("diagonal10.tif");
  save("diagonal15.png");
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
  float y0=2*min(width, height)/5;


  for (float y1=0; y1<1; y1+=1)
  {

    for (float x1=-1; x1<2; x1+=1)

    { 



      // sentence=""+(++letters[no])+"";

      noSmooth();
      if (no==1)
      {
        heart(n1*width+x1*y0, n2*height+y1*y0);
      }
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
       text(sentence1.charAt(pos), n1*width+x1*y0+z2*min(width, height)/20, n2*height+y1*y0+z1*min(width, height)/20);
       pos++;
       }
       }
       }
       */
      PFont font=loadFont("AgencyFB-Bold-255.vlw");//AgencyFB-Bold-255.vlw");
      textFont(font, min(width, height)/5);
      textAlign(CENTER, CENTER);
      if (cal==0 || cal==1)
      {
        fill(80, 80, 80);//255, 215, 0);
      }
      if (cal==0)
      {
        if (no<3 && no>=0 ) 
        {
          fill(255, 0, 0);
        }
        if (no<6 && no>=3 ) 
        {
          fill(0, 200, 255);
        }
      }
      text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
      no++;
    }
  }

  float y11=min(width, height)/5;

  float s1=y11;
  noFill();
  stroke(0, 255, 180, 180);
  strokeWeight(min(width, height)/80); 
  strokeJoin(MITER);
  noSmooth();
  beginShape();
  for (float n=0; n<360; n=n+90)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    vertex(a1, a2);///
  }
  endShape(CLOSE);
}

