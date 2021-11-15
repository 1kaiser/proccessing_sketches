int i, j;

float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;


void setup() 
{
  background(240);
  size( 1920, 1080);
  c_centre();
  /*

   icolour1=color(0, 0, 255);
   icolour2=color(0, 255, 255);
   
   for (n=0; n<dist (0, 0, i, j); n+=5)
   {
   
   stroke(lerpColor(icolour1, icolour2, map(n, 0, 2*dist(0, 0, i, j), 0, 1)));
   strokeWeight(5);
   noFill();
   noSmooth();
   ellipse(i, j, 2*n, 2*n);//central circle
   }
   */
  float n1=.5, n2=.5;
  icolour1=color(0, 0, 255);
  icolour2=color(0, 255, 255);
  for (n=180; n>0; n=n-.1)
  {
    noStroke();
    fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    // strokeWeight(50);
    noSmooth();
    arc(n1*width, n2*height, .4*width, .4*width, (PI/2 -radians(n))+3/2*PI, (PI/2 +radians(n))+3/2*PI, OPEN);
    // rotation++;
  }
  n1=.7; 
  n2=.5;
  float y11=min(width, height)/10;

  float s1=y11;
  for ( n=0; n<120; n=n+120)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+s1*cos(3*PI/2+radians(n+120));
    float b2=n2*height+s1*sin(3*PI/2+radians(n+120));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+240));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+240));    
    noFill();
    stroke(color(50, 50, 50, 255));
    strokeWeight(70); 
    strokeJoin(MITER);
    noSmooth();
    // triangle(a1, a2, b1, b2, c1, c2);///

    stroke(color(255, 0, 0, 255));
    strokeWeight(50); 
    //triangle(a1, a2, b1, b2, c1, c2);///
  }

  {
    sentence="FOCUS";
    int no=0;
    n1=.5; 
    n2=.5;
    float y0=min(width, height)/10;
    for (float y1=0; y1<1; y1+=1)
    {

      for (float x1=-2; x1<2+1; x1+=1)

      { 
        font=loadFont("SkyFallDone-255.vlw");
        textFont(font, min(width, height)/15);
        textAlign(CENTER, CENTER);
        fill(10);
        text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
        no++;
      }
    }
  }
  filter(POSTERIZE, 100);
  filter(BLUR, 40);

  {
    sentence="FOCUS";
    int no=0;
    n1=.5; 
    n2=.5;
    float y0=min(width, height)/10;
    for (float y1=0; y1<1; y1+=1)
    {

      for (float x1=-2; x1<2+1; x1+=1)

      { 
        font=loadFont("SkyFallDone-255.vlw");
        textFont(font, min(width, height)/15);
        textAlign(CENTER, CENTER);
        fill(255);
        text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
        no++;
      }
    }
  }

  save("x.png");
  // save("diagonal6.tif");
}
void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

