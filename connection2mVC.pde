int i, j;

float  ang1=0, n, cal;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/

float n1, n2;


void setup() 
{
  background(255);
  size( 7860, 4320);
  c_centre();





  n1=.5; 
  n2=.5;
  color icolour2=color(150, 150, 150);
  color icolour1=color(255, 255, 255);

  for (n=0; n<1.1*dist (0, 0, width, height); n+=1)
  {

    stroke(lerpColor(icolour1, icolour2, map(n, 0, 1.1*dist (0, 0, width, height), 0, 1)));
    strokeWeight(2);
    noFill();
    noSmooth();
    ellipse(n1*width, n2*height, 2*n, 2*n);//central circle
  }





  heart(n1*width, n2*height);

  PFont font=loadFont("AgencyFB-Bold-255.vlw");//AgencyFB-Bold-255.vlw");
  textFont(font, min(width, height)/10);
  textAlign(CENTER, CENTER);
  sentence="GOD";

  fill(220, 220, 220);//255, 215, 0);
  text(sentence, n1*width, n2*height);


  endShape(CLOSE);


  //save("diagonal10.tif");
  save("diagonal15.png");
  //save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

void heart(float q1, float q2)
{
  color icolour1=color(255, 0, 100);
  color icolour2=color(255, 0, 0);
  float p=2*min(width, height)/10;
  float s=p/sqrt(2);
  noSmooth();
  noStroke();
  fill(255, 0, 0);
  quad(q1, q2-s, q1+s, q2, q1, q2+s, q1-s, q2);
  for (float v=90; v>0; v=v-.1)
  {

    noStroke();
    noSmooth();
    fill(lerpColor(icolour1, icolour2, map(v, 0, 90, 0, 1)));
    arc(q1-s/2, q2-s/2, p, p, PI+PI/4-radians(v), PI+PI/4+radians(v), OPEN);
    arc(q1+s/2, q2-s/2, p, p, -PI/4-radians(v), -PI/4+radians(v), OPEN);
  }
}

