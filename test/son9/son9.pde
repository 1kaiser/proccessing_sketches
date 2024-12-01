int l=100, p=500, c1=1, i1=5, i2;
float a=1, b=100, i, k, j=20, m1=0, m2=0, m3;
float inc = radians(15), re=radians(30);
String  sentence="5";
//PFont //font1;
color c;
//PImage //img;


void setup() {
  //size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  //size( 7860/3, 4320/3);//size( 8192/3, 5120/3);
  ////background(50);

  //img = loadImage("v.jpg");
  int ll=1;
  size( 7860/3, 4320/3);//size( 7860*ll, 4320*ll);
  //image(//img, 0, 0, width, height);
  // filter(GRAY);

  noSmooth();
  float n1=.5, n2=.4;
  float y11=min(width, height)/5;

  float s1=y11;
  noFill();
  stroke(255);
  strokeWeight(min(width, height)/300);
  //ellipse(n1*width, n2*height, s1*2, s1*2);
  noStroke();
  fill(0, 150);
  rect(width*.2, height*.2, width-2*width*.2, height-2* height*.4);
  n1=.5; 
  n2=.1;
  y11=min(width, height)/20;

  s1=y11;
  for (float n=0; n<120; n=n+120)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+s1*cos(3*PI/2+radians(n+120));
    float b2=n2*height+s1*sin(3*PI/2+radians(n+120));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+240));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+240));
    noFill();
    stroke(color(255, 0, 0));
    strokeWeight(min(width, height)/150); 
    strokeJoin(MITER);
    noSmooth();
    triangle(a1, a2, b1, b2, c1, c2);///
  }
  sentence="Sajna de ba jo main te\nJike hun ki karna rabba\n\nHaathon ki Kismat Ka \nKoi jaane Na maane\nYe saath hai kitnaa Haseen\n\nkash ye pal tham jaaye\nAap ke hum ban jaaye\nJannat bhulake hum teri\nAankhon ke ashq ban jaaye ";
  //font1=loadFont("MVBoli-255.vlw");
  ////font1=loadFont("AgencyFB-Bold-255.vlw");
  //textFont(//font1, min(width, height)/30);
  textAlign(CENTER, CENTER);
  fill(0);
  noSmooth();
  n1=.5;
  n2=.3;
  //text(sentence, n1*width, n2*height);
  float gap=min(width, height)/15;
  noSmooth();
  sentence="IT KEEPS GETTING BETTER\nEVERYDAY NONSTOP";
  //PFont //font=loadFont("LHFOldBlock-255.vlw");//AgencyFB-Bold-255.vlw");
  //textFont(//font, gap);
  textAlign(CENTER, CENTER);
  fill(255);//255, 215, 0);
  text(sentence, n1*width, n2*height);//+s1+gap*2);


  save("sat11.jpeg");
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
