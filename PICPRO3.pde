int l=500;
float a = 0.0, b = 8, i, j, k, m1=0, m2=0, m3;
float inc = radians(45), re=radians(90);
String   sentence="5";
PFont font;
float n1, n2;
PImage img;
float cal;

void setup() {
  img = loadImage("iss040e010643 Moon_14851018951_o.jpg");

  size( img.width, img.height);
  background(img);
  noSmooth();
  n1=.5; 
  n2=.7;
  float y11=min(width, height)/4;

  float s1=y11;

  // heart(n1*width, n2*height);
  float gap=min(width, height)/30;
  noSmooth();
  sentence="MOON";
  PFont font=loadFont("Moonbeam-255.vlw");//AgencyFB-Bold-255.vlw");
  textFont(font, gap);
  textAlign(CENTER, CENTER);
  fill(255);//255, 215, 0);
  text(sentence, n1*width, n2*height);




  save("iss040e010643 Moon_14851018951_o.png");
}
void heart(float q1, float q2)
{
  color icolour1=color(255, 0, 100);
  color icolour2=color(255, 0, 0);
  float p=2*min(width, height)/20;
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

