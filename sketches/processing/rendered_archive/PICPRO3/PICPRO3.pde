int l=500;
float a = 0.0, b = 8, i, j, k, m1=0, m2=0, m3;
float inc = radians(45), re=radians(90);
String   sentence="5";
//PFont //font;
float n1, n2;
//PImage //img;
float cal;

void setup() {
  //img = loadImage("iss040e010643 Moon_14851018951_o.jpg");

  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  //background(//img);
  noSmooth();
  n1=.5; 
  n2=.5;
  float y11=min(width, height)/4;

  float s1=y11;
  noFill();
  stroke(255);
  strokeWeight(min(width, height)/300);
  ellipse(n1*width, n2*height, s1*2, s1*2);


  color icolour1=color(0, 255, 0);
  color icolour2=color(0, 255, 255);
  for (float n=180; n>0; n=n-.1)
  {
    noStroke();
    fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    // strokeWeight(50);
    noSmooth();
    arc(n1*width, n2*height+s1, s1/1.6, s1/1.6, PI/2 -radians(n), PI/2+radians(n), OPEN);
    // rotation++;
  }
  fill(0, 0, 0, 50);
  strokeWeight(min(width, height)/80); 
  strokeJoin(MITER);
  noSmooth();
  noStroke();
  beginShape();
  for (float n=0; n<360; n=n+90)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    // vertex(a1, a2);///
  }
  endShape(CLOSE);
  // heart(n1*width, n2*height);
  float gap=min(width, height)/30;
  noSmooth();
  sentence="MOON";
  //PFont //font=loadFont("Moonbeam-255.vlw");//AgencyFB-Bold-255.vlw");
  //textFont(//font, gap);
  textAlign(CENTER, CENTER);
  fill(255);//255, 215, 0);
  text(sentence, n1*width, n2*height+s1+gap+s1/1.6/2);




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

