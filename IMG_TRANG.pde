int l=100, p=500, c1=1, i1=5, i2;
float a=1, b=100, i, k, j=20, m1=0, m2=0, m3;
float inc = radians(15), re=radians(30);
String   sentence="5";
PFont font1;
color c;
PImage img;

void setup() {
  img = loadImage("sat1.png");

  size( img.width, img.height);
  background(img);
  //size( 7860, 4320);
  //size( 8192 , 5120);
  //background(220, 220, 220);
  float n1=.5, n2=.5;
  float y11=min(width, height)/2.5;

  float s1=y11;
  for (float n=90; n<90+120; n=n+120)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+s1*cos(3*PI/2+radians(n+120));
    float b2=n2*height+s1*sin(3*PI/2+radians(n+120));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+240));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+240));
    noFill();
    stroke(color(100, 100, 100, 200));
    strokeWeight(100); 
    strokeJoin(MITER);
    noSmooth();
    triangle(a1, a2, b1, b2, c1, c2);///
  }
  sentence="WE  MET\n\nFOR  A  REASON\n\nEITHER  YOU'RE  A\n\nBLESSING  OR\n\nA  LESSON.";
  font1=loadFont("SFMoviePoster-255.vlw");
  //font1=loadFont("AgencyFB-Bold-255.vlw");
  textFont(font1, 250);
  textAlign(LEFT, CENTER);
  fill(255, 255, 255);
  noSmooth();
  text(sentence, width/2.4, height/2);


  save("sat11.png");
}
/*void section()   //6
 {
 m1=random(0, width);
 m2=random(0, width);
/* while (m1==0||m2==0|| (max (m1, m2)-min(m1, m2))<5*l|| (max (m1, m2)-min(m1, m2))>7*l  )
 {
 section();
 }
 m3=max(m1, m2);
 m1=min(m1, m2);
 
 }
 */
