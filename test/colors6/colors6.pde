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
  icolour1=color(250, 0, 255, 10);
  icolour2=color(250, 255, 50, 10);
  float sier=min(height, width);
  float l=sier*.4;
  float n3=.5; 
  float inc = radians(15), re=radians(30);
  noStroke();

  for (float n=0; n<360; n+=1)
  { 
    float n1=.5, n2=1.1;
    float a1=n1*width+sier*1.1*cos(radians(n));
    float a2=n2*height+sier*1.1*sin(radians(n));
    fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
    ellipse(a1, a2, sier*2.2, sier*2.2 );
  }
  {
    float n1, n2;
    n1=.5;
    n2=.1;

    icolour1=color(255, 31, 117);
    icolour2=color(255, 13, 78);

    float dia=min(height, width)/5*.9;
    for (n=180; n>0; n=n-1)
    {
      noStroke();
      fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
      arc( width*n1, height*n2, dia, dia, PI/2 -radians(n), PI/2+radians(n), OPEN);
    }
    float siz=min(width, height)/20;
    //font=loadFont("CenturyGothic-255.vlw");
    //textFont(//font, siz);
    textAlign(CENTER, CENTER);
    fill(240);
    String   sentence1="DIAL";
    text(sentence1, width*n1, height*n2);
  }


  sentence="SLNOV1_AGK";

  int no=0;
  float y0=min(width, height)/4;

  for (float y1=-0.5; y1<1; y1+=1)
  {

    for (float x1=-2; x1<3; x1+=1)

    { 



      // sentence=""+(++letters[no])+"";

      noSmooth();
      {
        float n1, n2;
        n1=.5;
        n2=.5;

        icolour1=color(255, 31, 117);
        icolour2=color(255, 13, 78);

        float dia=min(height, width)/5*1.1;
        //for (n=180; n>0; n=n-1)
        {
          noStroke();
          // fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
          fill(0, 5);
          ellipse(width/2+x1*y0, height/2+y1*y0, dia, dia);
          //arc(width/2+x1*y0, height/2+y1*y0, dia, dia, PI/2 -radians(n), PI/2+radians(n), OPEN);
        }
      }

      if (no==6) 
      {
        float siz=min(width, height)/35;
        //font=loadFont("CenturyGothic-255.vlw");
        //textFont(//font, siz);
        textAlign(CENTER, CENTER);
        fill(255, 255, 0);
        int pos=0;
        for (float z1=-1.5; z1<2; z1+=1)
        {
          for (float z2=0; z2<1; z2+=1)
          { 
            String   sentence1="ZERO";
            text(sentence1.charAt(pos), width/2+x1*y0+z2*siz, height/2+y1*y0+z1*siz);
            pos++;
          }
        }
      }
      //font=loadFont("CenturyGothic-255.vlw");
      //textFont(//font, min(width, height)/8);
      textAlign(CENTER, CENTER);
      fill(255);
      if (no==6) 
      {
        fill(200);
      }
      text(sentence.charAt(no), width/2+x1*y0, height/2+y1*y0);
      no++;
    }
  }






  save("diagonal5.png");
  //  save("diagonal5.tiff");
  //  save("diagonal5.jpeg");
}

