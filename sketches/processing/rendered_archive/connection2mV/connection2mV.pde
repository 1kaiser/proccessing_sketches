int i, j;

float  ang1=0, n, cal;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/

float n1, n2;


void setup() 
{
  //background(255);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
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



  //PFont //font=loadFont("AgencyFB-Bold-255.vlw");//AgencyFB-Bold-255.vlw");
  //textFont(//font, min(width, height)/20);
  textAlign(CENTER, CENTER);
  sentence="I ALREADY KNOW\nWHAT GIVING UP\nFEELS LIKE.\n\nI WANT TO SEE.";

  fill(80, 80, 80);//255, 215, 0);
  text(sentence, n1*width, n2*height);
  sentence="\n\n\n\n\n\n\nWHAT HAPPENS\nIF I DON'T.";

  fill(255, 30, 30);//255, 215, 0);
  text(sentence, n1*width, n2*height);


  float y11=min(width, height)/3;

  float s1=y11;
  noFill();
  stroke(0, 255, 180, 180);
  strokeWeight(min(width, height)/80); 
  strokeJoin(MITER);
  noSmooth();
  beginShape();
  for (float n=0; n<360; n=n+15)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    vertex(a1, a2);///
  }
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

