int i, j;

float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;


void setup() 
{
  background(255);
  size( 7860, 4320);
  c_centre();


  icolour1=color(255, 255, 255, 50);
  icolour2=color(0, 0, 0);

  for (n=0; n<dist (0, 0, i, j); n+=5)
  {

    stroke(lerpColor(icolour1, icolour2, map(n, 0, 2*dist(0, 0, i, j), 0, 1)));
    strokeWeight(7);
    noFill();
    noSmooth();
    ellipse(i, j, 2*n, 2*n);//central circle
  }


  icolour1=color(0, 255, 0);
  icolour2=color(0, 255, 255);
  for (n=180; n>0; n=n-.1)
  {
    noStroke();
    fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    // strokeWeight(50);
    noSmooth();
    arc(.5*width, 1.2*height, .6*width, .6*width, PI/2 -radians(n), PI/2+radians(n), OPEN);
    // rotation++;
  }
  float n1=.5, n2=.5;
  float y11=min(width, height)/10;

  float s1=y11;
  for (float n=0; n<120; n=n+120)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+s1*cos(3*PI/2+radians(n+120));
    float b2=n2*height+s1*sin(3*PI/2+radians(n+120));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+240));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+240));
    noFill();
    stroke(color(255, 0, 0, 200));
    strokeWeight(50); 
    strokeJoin(MITER);
    noSmooth();
    triangle(a1, a2, b1, b2, c1, c2);///
  }



  save("diagonal5.png");
  save("diagonal5.tif");
}
void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

