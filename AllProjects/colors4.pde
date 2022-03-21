float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;

void setup() 
{
  background(255);
  size( 7860, 4320);
  noSmooth();

  {
    icolour1=color(30, 150, 255, 10);
    icolour2=color(180, 10, 255, 10);
    float sier=min(height, width);
    float l=sier*.4;
    float n3=.5; 
    float inc = radians(15), re=radians(30);
    noStroke();
    float n1=.6, n2=1.2;
    for (float n=0; n<360; n+=15)
    { 

      float a1=n1*width+sier*1.1*cos(radians(n));
      float a2=n2*height+sier*1.1*sin(radians(n));
      fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
      ellipse(a1, a2, sier*2.2, sier*2.2 );
    }
  }

  {
    float n1, n2;
    n1=.5;
    n2=.5;

    icolour1=color(255, 10, 0);
    icolour2=color(255, 50, 100);

    float dia=min(height, width)/5*1.1;
    for (n=180; n>0; n=n-.01)
    {
      noStroke();
      fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
      arc(n1*width, n2*height, dia, dia, PI/2 -radians(n), PI/2+radians(n), OPEN);
    }
  }

  /*
  {
   String  sentence="17111995";
   int no=0;
   float y0=min(width, height)/25;
   
   float n1=.4, n2=.5;
   
   for (float y1=-0.5; y1<1; y1+=1)
   {
   
   for (float x1=-1.5; x1<2; x1+=1)
   
   { 
   font=loadFont("GreekDinerInlineTT-255.vlw");
   textFont(font, min(width, height)/20);
   textAlign(CENTER, CENTER);
   fill(255);
   text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
   no++;
   }
   }
   }
   */
  save("diagonal5.png");
  //  save("diagonal5.tiff");
  //  save("diagonal5.jpeg");
}

