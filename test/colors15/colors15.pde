float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre

//PImage //img;

void setup() 
{
  int llll=1;
  //img = loadImage("c ("+llll+").jpg");
  int ll=2;
  size( 7860/3, 4320/3);//size( //img.width*ll, //img.height*ll);


  //if (//img.width///img.height<=1)
  //{
  //  float rat=//img.width*height///img.width;
  //  //image(//img, 0, -rat/2+height/2, width, rat/2+height/2);
  //} 
  //if (//img.width///img.height>1) 
  //{
  //  float rat=//img.height*width///img.height;
  //  //image(//img, -rat/2+width/2, 0, rat/2+width/2, height);
  //}
  // size( 7860/3, 4320/3);//size( //img.width*ll, //img.height*ll);
  ////image(//img, -//img.width/2, 0, //img.width/2, height);
  // filter(GRAY);
  filter(POSTERIZE, 100);
  strokeWeight(min(width, height)/200);
  //stroke(255, 150, 10);
  color icolour1=color(255, 200, 10);
  color icolour2=color(255, 100, 10);
  float v1=.2, v2=.5, v3=.8, v4=.5;
  // line(v1*width, v2*height, v3*width, v4*height);
  {

    for (float j= v2*height; j<= v4*height; j++)
    {  
      for (float i= v1*width; i<= v3*width; i++)
      { 
        stroke(lerpColor(icolour1, icolour2, map(i, v1*width, v3*width, 0, 1)));
        point(i, j);
      }
    }
  }

  {
    {
      smooth();


      float y0=min(width, height)/30;
      {
        float n1=v1, n2=v2, n3=.035, n4=.03;
        noStroke();
        // fill(255, 50, 50);
        //rect(width*.4-4, height*.3-4, width*1-2*(width*.4-4), height*.32+2*4, min(width, height)/50);
        strokeWeight(min(width, height)/200);
        //stroke(255);
        // noFill();
        fill(icolour1);
        rect(n1*width-width*n3, n2*height-height*n4, 2*width*n3, 2*height*n4, min(width, height)/100);
        //fill(210);
        //rect(width*.4, height*.4, width*1-2*width*.4, height-2* height*.4, 0);
      }
      String sentence="HOME";
      int no=0;
      float n1=v1, n2=v2;
      for (float y1=0; y1<1; y1+=1)
      {

        for (float x1=-1.5; x1<2; x1+=1)

        { 
          //font=loadFont("MicrosoftJhengHeiLight-255.vlw");
          //textFont(//font, min(width, height)/30);
          textAlign(CENTER, CENTER);
          fill(255);
          text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
          no++;
        }
      }
    }
  }
  {
    {
      smooth();


      float y0=min(width, height)/30;
      {
        float n1=v3, n2=v4, n3=.035, n4=.03;
        noStroke();
        // fill(255, 50, 50);
        //rect(width*.4-4, height*.3-4, width*1-2*(width*.4-4), height*.32+2*4, min(width, height)/50);
        strokeWeight(min(width, height)/200);
        //stroke(255);
        // noFill();
        fill(icolour2);
        rect(n1*width-width*n3, n2*height-height*n4, 2*width*n3, 2*height*n4, min(width, height)/100);
        //fill(210);
        //rect(width*.4, height*.4, width*1-2*width*.4, height-2* height*.4, 0);
      }
      String sentence="AWAY";
      int no=0;
      float n1=v3, n2=v4;
      for (float y1=0; y1<1; y1+=1)
      {

        for (float x1=-1.5; x1<2; x1+=1)

        { 
          //font=loadFont("MicrosoftJhengHeiLight-255.vlw");
          //textFont(//font, min(width, height)/30);
          textAlign(CENTER, CENTER);
          fill(255);
          text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
          no++;
        }
      }
    }
  }
  /*noSmooth();
   {
   icolour2=color(255, 1);
   icolour1=color(0, 1);
   float sier=min(height, width);
   float l=sier*.4;
   float n3=.5; 
   float inc = radians(15), re=radians(30);
   noStroke();
   float n1=.5, n2=1.1;
   for (float n=0; n<720; n+=2)
   { 
   
   float a1=n1*width+sier*1.1*cos(radians(n));
   float a2=n2*height+sier*1.1*sin(radians(n));
   fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
   ellipse(a1, a2, sier*2.2, sier*2.2 );
   }
   }
   
   {
   icolour1=color(255, 10);
   icolour2=color(0, 10);
   float sier=min(height, width)/10*.85/2;
   float l=sier*.4;
   float n3=.5; 
   float inc = radians(15), re=radians(30);
   noStroke();
   float n1=.9, n2=.2;
   for (float n=0; n<360; n+=5)
   { 
   
   float a1=n1*width+sier*1.1*cos(radians(n));
   float a2=n2*height+sier*1.1*sin(radians(n));
   fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
   ellipse(a1, a2, sier, sier);
   }
   }
   
   
   {
   float n1, n2;
   n1=.9;
   n2=.2;
   
   icolour1=color(0, 255, 130);
   icolour2=color(0, 240, 110);
   
   float dia=min(height, width)/5*1.2/2;
   for (n=180; n>0; n=n-1)
   {
   noStroke();
   fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
   arc( width*n1, height*n2, dia, dia, PI/2 -radians(n), PI/2+radians(n), OPEN);
   }
   n1=.825;
   n2=.2;
   float siz=min(width, height)/10;
   //font=loadFont("CenturyGothic-255.vlw");
   //textFont(//font, siz);
   textAlign(CENTER, CENTER);
   String sentence1="Web";
   fill(0, 240, 110);
   text(sentence1, width*n1, height*n2);
   }*/

  save("diagonalck ("+llll+").png");
  // save("diagonalc ("+llll+").tiff");
  save("diagonalck ("+llll+").jpg");
}
