float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
  rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;

void setup() 
{
  background(250);
  size( 7860, 4320);
  noSmooth();
  /* {
   icolour2=color(255,0,0,100);
   icolour1=color(255,255,0,100);
   float sier=min(height, width);
   float l=sier*.4;
   float n3=.5; 
   float inc = radians(15), re=radians(30);
   noFill();
   float n1=.5, n2=0;
   strokeWeight(sier/100);
   for (float n=0; n<360; n+=2)
   { 
   
   float a1=n1*width+sier*1.1*cos(radians(n));
   float a2=n2*height+sier*1.1*sin(radians(n));
   stroke(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
   ellipse(a1, a2, sier*4, sier*4 );
   }
   }*/

  {
    icolour1=color(19, 136, 8, 30);
    icolour2=color(255, 153, 51, 30);
    float sier=min(height, width)/10;
    float l=sier*.4;
    float n3=.5; 
    float inc = radians(15), re=radians(-90);
    noStroke();
    float n1=.5, n2=.5;
    for (float n=0; n<360; n+=5)
    { 

      float a1=n1*width+sier*1.1*cos(radians(n)+re);
      float a2=n2*height+sier*1.1*sin(radians(n)+re);
      fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
      ellipse(a1, a2, sier, sier);
    }
  }


  {
    float n1, n2;
    n1=.5;
    n2=.5;

    icolour1=color(255);
    icolour2=color(255);

    float dia=min(height, width)/5*1.2;
    for (n=180; n>0; n=n-1)
    {
      noStroke();
      fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
      arc( width*n1, height*n2, dia, dia, PI/2 -radians(n), PI/2+radians(n), OPEN);
    }
    float siz=min(width, height)/10;
    font=loadFont("AgencyFB-Bold-255.vlw");
    textFont(font, siz);
    textAlign(CENTER, CENTER);
    fill(0, 0, 128, 200);
    String   sentence1="69";
    text(sentence1, width*n1, height*n2);
  }
  save("diagonal9.png");
  //  save("diagonal5.tiff");
  //  save("diagonal5.jpeg");
}