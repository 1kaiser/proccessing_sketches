int i, j;

float an1=15, an2=15, h=30, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), C=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
float n1, n2;
float cal;

void setup() 
{
  background(255);
  size( 7860, 4320);
  //size(  8192, 5120 );
  c_centre();
  icolour1=color(255);
  icolour2=color(90, 0, 180);
  n1=1;
  n2=.5;
  for (n=0; n<sqrt (2)*dist (0, 0, width, height); n=n+h)
  {
    stroke(lerpColor(icolour1, icolour2, map(n, 0, sqrt (2)*dist (0, 0, width, height), 0, 1)));
    //fill(lerpColor(icolour1, icolour2, map(n, 0, dist (0, 0, i, j), 0, 1)));
    strokeWeight(20);
    smooth();
    // arc(i, j, 2*n, 2*n, ang1+rotation, ang2+rotation, OPEN);
    // arc(i, j, 2*n, 2*n, ang1+rotation+PI, ang2+rotation+PI, OPEN);
    line(n1*width+n, n2*height-height, n1*width+n, n2*height+height);
    line(n1*width-n-h, n2*height-height, n1*width-n-h, n2*height+height);
    //    line(i-width, j+n, i+width, j+n);
    //    line(i-width, j-n-h, i+width, j-n-h);
    line(n1*width+n+h-width/2, n2*height-width/2, n1*width+n+h+width/2, n2*height+width/2);
    line(n1*width-n-width/2, n2*height-width/2, n1*width-n+width/2, n2*height+width/2);
    line(n1*width+n+h+width/2, n2*height-width/2, n1*width+n+h-width/2, n2*height+width/2);
    line(n1*width-n+width/2, n2*height-width/2, n1*width-n-width/2, n2*height+width/2);
  }
  /*
  icolour=color(255);
   for (n=0; n<250*sqrt (2); n++)
   {
   
   stroke(icolour);
   strokeWeight(1);
   noFill();
   noSmooth();
   ellipse(i, j, 2*sqrt(2)*n, 2*sqrt(2)*n);//central circle
   }
   */
  n1=.7;
  n2=.5;  
  icolour1=color(255);
  icolour2=color(180, 110, 220);
  color icolour3=color(0, 0, 0, 1);
  color icolour4=color(255, 255, 255, 1);
  float rad=.6*height;
  float s1=rad/1.6;

  fill(0, 0, 0, 80);
  noStroke();
  noSmooth();
  beginShape();
  for (float n=0; n<360; n=n+.1)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    vertex(a1, a2);///
  }
  endShape(CLOSE);

  for (n=180; n>0; n=n-.1)
  {


    noSmooth();
    noFill();
    stroke(255, 230, 0);
    strokeWeight(20);
    arc(n1*width, n2*height, rad-50, rad-50, PI/2-PI/2 -radians(n), PI/2-PI/2+radians(n), OPEN);
    stroke(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    strokeWeight(30);
    arc(n1*width, n2*height, rad, rad, PI/2-PI/2 -radians(n), PI/2-PI/2+radians(n), OPEN);

    // rotation++;
  }




  sentence="TOGETHER";

  n1=.5;
  n2=.9;  

  font1=loadFont("ArialRoundedMTBold-255.vlw");
  textFont(font1, 500);
  textAlign(CENTER, CENTER);
  fill(255);
  noSmooth();
  text(sentence, n1*width, n2*height);

  n1=.5;
  n2=.7;
  sentence="";
  font1=loadFont("HelveticaNeue-UltraLight-255.vlw");
  textFont(font1, 200);
  textAlign(CENTER, TOP);
  fill(130, 120, 0);
  noSmooth();
  text(sentence, n1*width, n2*height);


  char[] letters = { 
    //  'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y', 
    // 5, 2, 4, 7, 3, 7, 7, 6, 9
    'K', '2', '4', '7', 'E', '7', '7', '6', 'Y',
  };

  int no=0;

  n1=1.5;
  n2=.9;
  float y2=min(width, height)/5*sqrt(2);
  float y0=2*y2/15;
  for (float y1=-y0; y1<=y0; y1+=y0)
  {

    for (float x1=-y0; x1<=y0; x1+=y0)

    { 


      stroke(color(0, 200, 255));
      strokeWeight(5);
      fill(color(0, 150, 255));
      noSmooth();
      ellipse(n1*width+x1, n2*height+y1, 2*y2/20, 2*y2/20);

      sentence=""+letters[no]+"";
      no++;
      font=loadFont("AgencyFB-Bold-255.vlw");
      textFont(font, y2/13);
      textAlign(CENTER, CENTER);
      fill(255, 255, 0);
      noSmooth();

      text(sentence, n1*width+x1, n2*height+y1);
    }
  }


  save("diagonal11.png");
  //save("diagonal11.tif");
  //save("diagonal11.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}
void let()
{
  int no=0;
  float y0=2*min(width, height)/18;


  for (float y1=-.5; y1<1; y1+=1)
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
      //font=loadFont("LHFOldBlockCondMed-255.vlw");
      font=loadFont("ArialRoundedMTBold-255.vlw");
      textFont(font, min(width, height)/8);
      textAlign(CENTER, CENTER);
      if (cal==0 || cal==1)
      {
        fill(255);//255, 215, 0);
      }
      if (cal==1)
      {
        if (no<8 && no>=0 ) 
        {
          fill(255, 150, 30);
        }
        if (no>=8 ) 
        {
          fill(255, 30, 60);
        }
      }

      text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
      no++;
    }
  }
}


void heart(float q1, float q2)
{
  color icolour1=color(255, 255, 0);
  color icolour2=color(255, 0, 100);
  float p=2*min(width, height)/30;
  float s=p/sqrt(2);
  noSmooth();
  noStroke();
  fill(255, 0, 100);
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

