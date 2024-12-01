float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;

void setup() 
{
  //background(255);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  noSmooth();
  {
    icolour2=color(255,1);
    icolour1=color(0, 10);
    float sier=min(height, width);
    float l=sier*.4;
    float n3=.5; 
    float inc = radians(15), re=radians(30);
    noStroke();
    float n1=.3, n2=1.1;
    for (float n=0; n<360; n+=15)
    { 

      float a1=n1*width+sier*1.1*cos(radians(n));
      float a2=n2*height+sier*1.1*sin(radians(n));
      fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
      ellipse(a1, a2, sier*2.2, sier*2.2 );
    }
  }
  {
    icolour2=color(0, 255, 190, 10);
    icolour1=color(0, 190, 255, 10);
    float sier=min(height, width)/5;
    float l=sier*.4;
    float n3=.5; 
    float inc = radians(15), re=radians(30);
    noStroke();
    float n1=.5, n2=.4;
    for (float n=0; n<360; n+=5)
    { 

      float a1=n1*width+sier*1.1*cos(radians(n));
      float a2=n2*height+sier*1.1*sin(radians(n));
      fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
      ellipse(a1, a2, sier*2.2, sier*2.2 );
    }
  }
  {
    icolour1=color(30, 150, 255, 10);
    icolour2=color(180, 10, 255, 10);
    float sier=min(height, width)/10;
    float l=sier*.4;
    float n3=.5; 
    float inc = radians(15), re=radians(30);
    noStroke();
    float n1=.5, n2=.32;
    for (float n=0; n<360; n+=5)
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
    n2=.4;

    icolour1=color(255, 31, 117);
    icolour2=color(255, 13, 78);

    float dia=min(height, width)/5*1.2;
    for (n=180; n>0; n=n-1)
    {
      noStroke();
      fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
      arc( width*n1, height*n2, dia, dia, PI/2 -radians(n), PI/2+radians(n), OPEN);
    }
    float siz=min(width, height)/10;
    //font=loadFont("AgencyFB-Bold-255.vlw");
    //textFont(//font, siz);
    textAlign(CENTER, CENTER);
    fill(240);
    String   sentence1="GOD";
    text(sentence1, width*n1, height*n2);
  }
  save("diagonal5.png");
  //  save("diagonal5.tiff");
  //  save("diagonal5.jpeg");
}

