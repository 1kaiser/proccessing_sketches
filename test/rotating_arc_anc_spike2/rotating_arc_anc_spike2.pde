int i, j;

float  ang1=0, ang2, tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  //background(255, 255, 255, 255);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  c_centre();
  icolour1=color(0, 0, 0, 100);
  icolour2=color(0, 0, 0);



  float n1=.5, n2=.9;
  float y11=min(width, height)/5*sqrt(2);
  stroke(255, 0, 0);
  noSmooth();
  noFill();
  float h=30;
  float s1=y11/2/sqrt(3);
  float l=s1*tan(radians(h/2));
  for (n=0; n<360; n=n+h)
  {

    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+(s1+l)*cos(3*PI/2+radians(n+h/2));
    float b2=n2*height+(s1+l)*sin(3*PI/2+radians(n+h/2));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+h));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+h));
    float d1=n1*width+s1*cos(3*PI/2+radians(n+h/2));
    float d2=n2*height+s1*sin(3*PI/2+radians(n+h/2));
    fill(color(255, 0, 0));
    noStroke();
    quad(a1, a2, b1, b2, c1, c2, d1, d2);///
  }


  char[] letters = { 
    //  'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y', 
    // 5, 2, 4, 7, 3, 7, 7, 6, 9
    'K', '2', '4', '7', 'E', '7', '7', '6', 'Y',
  };

  int no=0;

  float i=width*.50;
  float j=height*.90;
  float y2=min(width, height)/5*sqrt(2);
  float y0=2*y2/15;
  for (float y1=-y0; y1<=y0; y1+=y0)
  {

    for (float x1=-y0; x1<=y0; x1+=y0)

    { 


      stroke(color(255, 0, 0));
      strokeWeight(10);
      fill(color(255, 0, 0));
      noSmooth();
      ellipse(i+x1, j+y1, 2*y2/20, 2*y2/20);

      sentence=""+letters[no]+"";
      no++;
      //font=loadFont("AgencyFB-Bold-255.vlw");
      //textFont(//font, y2/13);
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      noSmooth();

      text(sentence, i+x1, j+y1);
    }
  }


  //save("diagonal10.tif");
  save("diagonal11.png");
  //save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

