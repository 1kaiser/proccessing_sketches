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

  //img = loadImage("c.jpg");
  size( 7860/3, 4320/3);//size( 7860*3, 4320*3);
  //image(//img, 0, 0, width, height);
  // filter(GRAY);
  noStroke();
  fill(0, 40);
  rect(width*.2, height*.15, width*.6, height*.7);
  float n1=.5, n2=.9;
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
  sentence="Kash Yea Pal\n\nsajna de bajo mai te ji k hud ki krna rabba\nanjubi hun muk gaye sare hurte mila de rabba\n\n\nkismat ka ye khel hai milna tha humne kabhi\nhaatho ki lakiro me likha tha ye sabhi\nkoi jane na maane ye sath hai kitna hansi\nkash yea pal tham jaye aapke hum ban jaye\njannat bhula k hum teri aankho k ashq ban jaye\nkash yea pal tham jaye aapke hum ban jaye\njannat bhula k hum teri aankho k ashq ban jaye...\n\n\n janam janma ka ye sath hai chhuta ye aise nahi\npyar tera aisa mila ki ab koi bhata nahi\nbaaho me aake teri saanso me simat jaye\nkash yea pal tham jaye aapke hum ban jaye\njannat bhula k hum teri aankho k ashq ban jaye\nkash yea pal tha jaye aapke hum ban jaye\njannat bhula k hum teri aankho k ashq ban jaye...\n\n\nashq ban jaye ye pal tham jay\nashq ban jaye ye pal tham jaye\nashq ban jaye ye pal tham jaye\nashq ban jaye ye pal tham jaye\nhaatho ki kismat ka koi jane na mane\nye sath hai kitna hansi\nkash ye..\naapke hum..\njannat bhula k hum teri aankho k ashq ban jaye\nkash yea pal tham jaye aapke hum ban jaye\njannat bhula k hum teri aankho k ashq ban jaye";
  //font1=loadFont("MVBoli-255.vlw");
  ////font1=loadFont("AgencyFB-Bold-255.vlw");
  //textFont(//font1, min(width, height)/50);
  textAlign(CENTER, CENTER);
  fill(255);
  noSmooth();
  n1=.5;
  n2=.5;
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
