int l=100, p=500, c1=1, i1=5, i2;
float a=1, b=100, i, k, j=20, m1=0, m2=0, m3;
float inc = radians(15), re=radians(30);
String   sentence="5";
PFont font1;
color c;
PImage img;


void setup() {
  //size( 7860, 4320);
  //size( 8192, 5120);
  //background(50);

  img = loadImage("b.jpg");

  size( img.width*4, img.height*4);
  image(img, 0, 0, width, height);
  // filter(GRAY);
  float n1=.5, n2=.95;
  float y11=min(width, height)/30;

  float s1=y11;
  for (float n=60; n<120; n=n+120)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+s1*cos(3*PI/2+radians(n+120));
    float b2=n2*height+s1*sin(3*PI/2+radians(n+120));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+240));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+240));
    noFill();
    stroke(color(255, 0, 0));
    strokeWeight(min(width, height)/180); 
    strokeJoin(MITER);
    noSmooth();
    triangle(a1, a2, b1, b2, c1, c2);///
  }
  sentence="koi sajan naal dil jalawe mudna aave na\nishq tereche pagal hoyo bhul gaya apni jaat\n\n\nzindgi meri kat hi rahi saanse meri chal hi rahi\ndil me tum bas baste ho keh na saka tumse kabhi\n\ntumse kabhiii";
  font1=loadFont("MVBoli-255.vlw");
  //font1=loadFont("AgencyFB-Bold-255.vlw");
  textFont(font1, min(width, height)/30);
  textAlign(CENTER, CENTER);
  fill(255);
  noSmooth();
  n1=.5;
  n2=.75;
  text(sentence, n1*width, n2*height);


  save("sat11.png");
  // save("sat11.tif");
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
