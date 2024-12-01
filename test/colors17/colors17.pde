float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
//PImage  //img;

void setup() 
{
  int llll=1;
  //img = loadImage("c ("+llll+").jpg");
  int ll=2;
  size( 7860/3, 4320/3);//size( //img.width, //img.height);


//  if (//img.width///img.height<=1)
//  {
//    float rat=//img.width*height///img.width;
//    //image(//img, 0, -rat/2+height/2, width, rat/2+height/2);
//  } 
//  if (//img.width///img.height>1) 
//  {
//    float rat=//img.height*width///img.height;
//    //image(//img, -rat/2+width/2, 0, rat/2+width/2, height);
//  }
  // size( 7860/3, 4320/3);//size( //img.width*ll, //img.height*ll);
  ////image(//img, -//img.width/2, 0, //img.width/2, height);
  // filter(GRAY);
  filter(POSTERIZE, 100);
  //background(255, 200, 0);
  {
    smooth();


    float y0=min(width, height)/30;
    {
      float n1=.5, n2=.75, n3=.07, n4=.03;
      stroke(250, 130);
      strokeWeight(min(width, height)/200);
      noFill();
      rect(n1*width-width*n3, n2*height-height*n4, 2*width*n3, 2*height*n4, min(n3*width, n4*height)/4);

      noStroke();
      fill(250);
      rect(n1*width-width*n3, n2*height-height*n4, 2*width*n3, 2*height*n4, min(n3*width, n4*height)/4);
    }
    String sentence="DELTAB";
    int no=0;
    float n1=.5, n2=.75;
    noSmooth();
    for (float y1=0; y1<1; y1+=1)
    {

      for (float x1=-2.5; x1<3; x1+=1)

      { 
        //font=loadFont("MicrosoftJhengHeiLight-255.vlw");
        //textFont(//font, min(width, height)/30);
        textAlign(CENTER, CENTER);
        fill(10);
        text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
        no++;
      }
    }
  }
  {
    float y11=min(width, height)/8;
    float n1=.5, n2=.5;
    float s1=y11;
    //  noFill();
    //  stroke(0, 255, 180, 180);
    fill(0);
    stroke(0);
    strokeWeight(min(width, height)/80); 
    strokeJoin(MITER);
    smooth();
    beginShape();
    for (float n=60; n<360; n=n+120)
    {
      float a1=n1*width+s1*cos(3*PI/2+radians(n));
      float a2=n2*height+s1*sin(3*PI/2+radians(n));

      vertex(a1, a2);///
    }
    endShape(CLOSE);
    noFill();
    {    
      for (float i=2; i<15; i++) 
      {
        s1=s1+1*min(width, height)/80/i;
        stroke(0, 150/i);
        strokeJoin(MITER);
        strokeWeight(min(width, height)/80/i); 
        beginShape();
        for (float n=60; n<360; n=n+120)
        {
          float a1=n1*width+s1*cos(3*PI/2+radians(n));
          float a2=n2*height+s1*sin(3*PI/2+radians(n));

          vertex(a1, a2);///
        }
        endShape(CLOSE);
      }
    }
  }
  {
    noSmooth();
    float n1=0, n2=.9, n3=1, n4=min(width, height)/200;
    strokeWeight(2); 
    strokeCap(SQUARE);
    for (float i=n1*width; i<=n3*width; i++) 
    {
      stroke(0, map(i, n1*width, n3*width, 1, 255));
      line(n3*width-i, n2*height+n4, n3*width-i, n2*height-n4);
    }
  }
  save("diagonalck ("+llll+").png");
  // save("diagonalc ("+llll+").tiff");
  save("diagonalck ("+llll+").jpg");
}
