float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre

PImage img;

void setup() 
{
  int llll=1;
  img = loadImage("c ("+llll+").jpg");
  int ll=2;
  size( img.width/4, img.height/4);


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
  filter(POSTERIZE, 100);
  {

    float h=min(width, height)/30;

    {
      float g = 6, rad = radians(g);
      float t2=rad;
      float t1=t2;
      float b=1.2;
      float n=min(width, height)/18; 

      float h1=30;
      float s1=300;

      float a=s1*sin(h1/2);
      float n1=.7, n2=.5;
      stroke(255, 100);
      strokeWeight(min(width, height)/10);
      color icolour1=color(200, 255, 20);
      color icolour2=color(220, 220, 220);
      for (int o=0; o<20; o++)
      {
        float c1=n1*width+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI/2);//n1*width+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI/2);
        float c2=n2*height+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI/2);
        stroke(lerpColor(icolour1, icolour2, map(o, 0, 10, 0, 1)));
        line(c1-n+width/2, n2*height-width/2, c1-n-width/2, n2*height+width/2);


        //d1=n1*width+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI/2);
        //=n2*height+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI/2);
        t2+=rad;
        //ne(c1, c2, d1, d2);
      }
    }
    float n1=.6, n2=.5;
    color icolour1=color(255, 200, 10);
    color icolour2=color(255, 100, 10);
    for (float n=n1*width; n<width; n=n+h)
    {
      //stroke(lerpColor(icolour1, icolour2, map(n, 0, width/2, 0, 1)));
      //fill(lerpColor(icolour1, icolour2, map(n, 0, dist (0, 0, i, j), 0, 1)));
      strokeWeight(300);
      smooth();
      // line(n1*width-n-h, n2*height-height, n1*width-n-h, n2*height+height);
      stroke(0, 5);
      line(n1*width-n-width/2, n2*height-width/2, n1*width-n+width/2, n2*height+width/2);
      stroke(255, 20, 80, 5);
      line(n1*width-n+width/2, n2*height-width/2, n1*width-n-width/2, n2*height+width/2);
    }
  }
  strokeWeight(min(width, height)/200);
  //stroke(255, 150, 10);
  color icolour1=color(255, 200, 10);
  color icolour2=color(255, 100, 10);
  float v1=.2, v2=.5, v3=.8, v4=.5;
  // line(v1*width, v2*height, v3*width, v4*height);
  smooth();

  float v5=dist(v1*width, v2*height, v3*width, v4*height);
  {

    for (float i = 0; i <= v5; i++) {
      float x = lerp(v1*width, v3*width, i/v5) ;
      float y = lerp(v2*height, v4*height, i/v5);
      stroke(lerpColor(icolour1, icolour2, map(i, 0, v5, 0, 1)));
      point(x, y);
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
          font=loadFont("MicrosoftJhengHeiLight-255.vlw");
          textFont(font, min(width, height)/30);
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
      { 
        int i=0; 
        float i1=1, i2=0, i3=0, i4=0;
        for (i=0; i<sentence.length (); i++) 
        {
          if (sentence.charAt(i)==' ')
          { 
            i1++;
            i4=i;
            i2=i-i2;
          }

          if (i3<=i2)
          {
            i3=i2;
          }
        }

        if (i3<=sentence.length ()-i4)
        {
          i3=sentence.length ()-i4;
        }

        int no=0;
        float n1=v3, n2=v4;
        for (float y1=-i1/2+.5; y1<i1/2; y1+=1)
        {
          for (float x1=-i3/2+.5; x1<i3/2; x1+=1)

          { 
            font=loadFont("MicrosoftJhengHeiLight-255.vlw");
            textFont(font, min(width, height)/30);
            textAlign(CENTER, CENTER);
            fill(255);
            //  if (sentence.charAt(no)!=' ')
            {

              text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
            }
            no++;
          }
        }
      }
    }
  }



  save("diagonalck ("+llll+").png");
  // save("diagonalc ("+llll+").tiff");
  save("diagonalck ("+llll+").jpg");
}

