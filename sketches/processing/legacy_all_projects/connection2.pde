int i, j;

float  ang1=0, ang2, tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  background(255);
  size( 7860, 4320);
  c_centre();


  icolour1=color(0, 255, 130);
  icolour2=color(0, 130, 255);
  color icolour3=color(255, 0, 255);
  color icolour4=color(255, 0, 130);



  float n1=.5, n2=.5;
  float rad=min(width, height)*.4;


  float s1=rad/4;
  for ( n=0; n<120; n=n+120)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+s1*cos(3*PI/2+radians(n+120));
    float b2=n2*height+s1*sin(3*PI/2+radians(n+120));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+240));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+240));    



    for (float v=180; v>0; v=v-.1)
    {

      strokeWeight(50);
      noSmooth();
      noFill();
      stroke(lerpColor(icolour1, icolour2, map(v, 0, 180, 0, 1)));
      arc(a1, a2, rad, rad, PI/2+PI/6-PI/2 -radians(v), PI/2+PI/6-PI/2+radians(v), OPEN);
      stroke(lerpColor(icolour2, icolour3, map(v, 0, 180, 0, 1)));
      arc(b1, b2, rad, rad, PI/2+PI/3-PI/2 -radians(v), PI/2+PI/3-PI/2+radians(v), OPEN);
      stroke(lerpColor(icolour3, icolour4, map(v, 0, 180, 0, 1)));
      arc(c1, c2, rad, rad, PI-PI/2 -radians(v), PI-PI/2+radians(v), OPEN);
      // rotation++;
    }
  }







  //save("diagonal10.tif");
  save("diagonal15.png");
  //save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

