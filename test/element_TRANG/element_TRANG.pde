int i, j;

float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;


void setup() 
{
  //background(240, 240, 240, 40);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  //size( 7860/3, 4320/3);//size( 8192/3, 5120/3);
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

  icolour1=color(255, 255, 255);
  icolour2=color(0, 255, 255);
  for (n=180; n>0; n=n-.1)
  {
    noStroke();
    fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    // strokeWeight(50);
    noSmooth();
    arc(i, j, 2*1000, 2*1000, 2*PI-PI/4 -radians(n), 2*PI-PI/4+radians(n), OPEN);
    // rotation++;
  }

  filter(BLUR, 20);
  float n1=.5, n2=.8;
  float y11=min(width, height)/10;

  float s1=y11;
  for (float n=180; n<180+120; n=n+120)
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


  sentence="SORRY";
  //font1=loadFont("ArialRoundedMTBold-255.vlw");
  //textFont(//font1, 250);
  textAlign(CENTER, CENTER);
  fill(70, 160, 255);
  noSmooth();
  text(sentence, width/2, height/2);



  save("diagonal71.png");
  save("diagonal71.TIF");
}
void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

