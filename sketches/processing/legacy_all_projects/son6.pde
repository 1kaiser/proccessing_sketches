int l=100, p=500, c1=1, i1=5, i2;
float a=1, b=100, i, k, j=20, m1=0, m2=0, m3;
float inc = radians(15), re=radians(30);
String  sentence="5";
PFont font1;
color c;
PImage img;


void setup() {
  //size( 7860, 4320);
  //size( 8192, 5120);
  //background(50);

  img = loadImage("v.jpg");
  int ll=6;
  size( img.width*ll, img.height*ll);
  image(img, 0, 0, width, height);
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
  fill(255, 80);
  rect(width*.5+width*.05, height*.2, width*.5-2*width*.05, height-2* height*.2);
  n1=.75; 
  n2=.9;
  y11=min(width, height)/30;

  s1=y11;
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
  sentence="Kuch is tarah teri palkain meri palkoon say mila day...\nAanso teray saaray meri palkoon pay saja day...\n\nTuu her ghari her waqat meray sath raha hai...\nHaan yeh jism kabhi door kabhi paas raha hai...\n\nJo bhi gham hain yeh teray unhain tu mera pata day...\n\nMujh ko to teray cehray pay yeh gham nahi jajta...\n\nJaiz nahi lagta mujhay gham say tera rishta...\nSun meri guzarish isay chehray say hata day...\nSun meri guzarish isay chehray say hata day\n\nKuch is tarah teri palkain meri palkoon say mila day...\nAanso teray saaray meri palkoon pay saja day...";
  font1=loadFont("MVBoli-255.vlw");
  //font1=loadFont("AgencyFB-Bold-255.vlw");
  textFont(font1, min(width, height)/50);
  textAlign(CENTER, CENTER);
  fill(255);
  noSmooth();
  n1=.75;
  n2=.5;
  text(sentence, n1*width, n2*height);
  float gap=min(width, height)/30;
  noSmooth();
  sentence="FAMOUS\nBASICS";
  PFont font=loadFont("RomanD-255.vlw");//AgencyFB-Bold-255.vlw");
  textFont(font, gap);
  textAlign(CENTER, CENTER);
  fill(255);//255, 215, 0);
  //text(sentence, n1*width, n2*height+s1+gap*2);


  save("sat11.jpeg");
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
