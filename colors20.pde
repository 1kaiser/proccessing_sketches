float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
PImage  img;

void setup() 
{
  int llll=1;
  img = loadImage("c ("+llll+").jpg");
  int ll=2;
  size( 7680, 4320);
  //size( img.width, img.height);


  if (img.width/img.height<=1)
  {
    float rat=img.width*height/img.width;
    image(img, 0, -rat/2+height/2, width, rat/2+height/2);
  } 
  if (img.width/img.height>1) 
  {
    float rat=img.height*width/img.height;
    image(img, -rat/2+width/2, 0, rat/2+width/2, height);
  }
  // size( img.width*ll, img.height*ll);
  //image(img, -img.width/2, 0, img.width/2, height);
  // filter(GRAY);
  // filter(POSTERIZE, 100);
  background(255, 0,100);
  {
    float y11=min(width, height)/8;
    float n1=.55, n2=.5;
    float s1=y11;
    //  noFill();
    //  stroke(0, 255, 180, 180);
    fill(255);
    stroke(255);
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
      for (float i=2; i<10; i++) 
      {
        s1=s1+1*min(width, height)/80/i;
        stroke(255, 250/i);
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
    smooth();


    float y0=min(width, height)/30;
    {
      float n1=.5, n2=.5, n3=.04, n4=.03;
      stroke(255, 80); 
      noFill();
      strokeWeight(min(width, height)/120);
      rect(n1*width-width*n3, n2*height-height*n4, 2*width*n3, 2*height*n4, min(n3*width, n4*height)/4);
      strokeWeight(min(width, height)/200);
      rect(n1*width-width*n3, n2*height-height*n4, 2*width*n3, 2*height*n4, min(n3*width, n4*height)/4);

      noStroke();
      fill(250);
      rect(n1*width-width*n3, n2*height-height*n4, 2*width*n3, 2*height*n4, min(n3*width, n4*height)/4);
    }
    String sentence="GOD";
    int no=0;
    float n1=.5, n2=.5;
    noSmooth();
    for (float y1=0; y1<1; y1+=1)
    {

      for (float x1=-1; x1<2; x1+=1)

      { 
        font=loadFont("MicrosoftJhengHeiLight-255.vlw");
        textFont(font, min(width, height)/30);
        textAlign(CENTER, CENTER);
        fill(10);
        text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
        no++;
      }
    }
  }

  {   
    float n1=0, n2=.88, n3=1, n4=.2;

    noStroke();
    fill(40);
    rect(n1*width, n2*height, width*n3, height*n4);
  }
  {
    noSmooth();
    float n1=0, n2=.9, n3=1, n4=min(width, height)/1000;
    strokeWeight(1); 
    strokeCap(SQUARE);
    for (float i=n1*width; i<=n3*width; i++) 
    {
      stroke(255, map(i, n1*width, n3*width, 1, 255));
      line(n3*width-i, n2*height+n4-.5, n3*width-i, n2*height-n4+.5);
    }
  }
  /*{
   float n1=.25/3, n2=.9;
   sentence="DEVOTE";
   font2=loadFont("Aharoni-Bold-255.vlw");
   textFont(font2, min(width, height)/35);
   textAlign(CENTER, CENTER );
   fill(255, 200, 0);
   noSmooth();
   text(sentence, n1*width, n2*height);
   }
   */  /*  {
   strokeWeight(min(width, height)/10);
   float v1=.2, v2=.1, v3=.8, v4=.7;
   smooth();
   float v5=dist(v1*width, v2*height, v3*width, v4*height);
   {
   
   for (float i = 0; i <= v5; i++)
   {
   float x = lerp(v1*width, v3*width, i/v5) ;
   float y = lerp(v2*height, v4*height, i/v5);
   stroke(0, map(i, 0, v5, 1, 255));
   point(x, y);
   }
   }
   }
   */

  save("diagonalck ("+llll+").png");
  //  save("diagonalc ("+llll+").tiff");
  save("diagonalck ("+llll+").jpg");
}

