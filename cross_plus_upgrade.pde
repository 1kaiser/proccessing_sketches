float i, j, spacer=10, fs=900, //font size 
n=10, //length of plus 
t=1, //strokewidth for plus sign
p;
PFont font;

String sentence="HAPPY\nRAINS";//text in the output 
color  c1= color(0, 143, 229), //background upper gradient 
c2= color(0, 159, 255), //background lower gradient 
c3= color(144, 79, 144), //dot colour 
c5= color(49, 164, 255, 200), //text colour 
c6= color(255, 255, 255, 50);// plus colour 
/*c1= color(0, 82, 131), //background upper gradient 
 c2= color(0, 159, 255), //background lower gradient 
 */




void setup()
{

  // background(0, 112, 201, 150);
  background(255);
 // size( 7860,4320 );
  size(  5120, 8192 );
  setGradient(0, 0, width, height, c1, c2);

  //setGradient(0, 0, width, height, c1, c2);// background 
  quadrants();// design of background 

  char[] letters = { 
    'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y', 
    5, 2, 4, 7, 3, 7, 7, 6, 9
  };

  int no=0;
  float y0=2*dist(0, 0, width, height)/15;

  for (float y1=-y0; y1<=y0; y1+=y0)
  {

    for (float x1=-y0; x1<=y0; x1+=y0)

    { 



      // sentence=""+(++letters[no])+"";
      sentence=""+(++letters[no])+"";
      no++;
      font=loadFont("AgencyFB-Bold-255.vlw");
      textFont(font, dist(0, 0, width, height)/13);
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      noSmooth();
      c_centre();
      text(sentence, width/2+x1, height/2+y1);
    }
  }

  //int no=0;
  c_centre();
  float i=width*.90;
  float j=height-width*.10;
  float y2=dist(width*.80, j-width*.10, width, height);
  y0=2*y2/15;
  for (float y1=-y0; y1<=y0; y1+=y0)
  {

    for (float x1=-y0; x1<=y0; x1+=y0)

    { 

      stroke(35, 35, 35);
      noSmooth();
      strokeWeight(50);

      fill(color(0, 0, 0, 200));
      noSmooth();
      // ellipse(width/2, height/2, 2*sqrt(2)*250*sqrt (2), 2*sqrt(2)*250*sqrt (2));//central circle
      stroke(color(0, 0, 0, 200));
      // strokeWeight(1);
      // noFill();
      noStroke();
      fill(color(0, 0, 0, 150));
      noSmooth();
      //noSmooth();
      /*      for (float n=0; n<dist (0, 0, width, height)/20; n++)
       {
       ellipse(i+x1, j+y1, 2*n, 2*n);//central circle
       }
       */      ellipse(i+x1, j+y1, 2*y2/20, 2*y2/20);
      /*    stroke(255);
       
       strokeWeight(y2/225);
       noFill();
       
       // ellipse(i, j, 2*sqrt(2)*250*sqrt (2), 2*sqrt(2)*250*sqrt (2));
       ellipse(i+x1, j+y1, (2/20-sqrt (2)/225)*y2, (2/20-sqrt (2)/225)*y2);
       
       */
      sentence=""+int(letters[no])+"";
      no++;
      font=loadFont("AgencyFB-Bold-255.vlw");
      textFont(font, y2/13);
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      noSmooth();

      text(sentence, i+x1, j+y1);
    }
  }
  sentence="BETTER\n\n";
  font=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  textFont(font, dist(0, 0, width, height)/90);
  textAlign(CENTER, BOTTOM );
  fill(255);
  noSmooth();
  text(sentence, width/2, height);
  save("diagonal14.tif");
}
//23.2143771,77.4140177

void quadrant_compoents()
{
  plus_cross();
  //dots();
}


void setGradient(int x, int y, float w, float h, color c1, color c2)
{

  noFill();

  {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      noSmooth();
      line(x, i, x+w, i);
    }
  }
}
void c_centre()
{
  float i=width/2;
  float j=height/2;
}

void quadrants()
{

  noSmooth();
  {
    {

      for (j=height/2-3*n; j >0; j-=3*n) {
        for (i=width/2+3*n; i <width; i+=3*n) {
          quadrant_compoents();
        }
      }
    }

    {

      for (j=height/2; j >0; j-=3*n) {
        for (i=width/2; i >0; i-=3*n) {
          if (j==height/2&&i==width/2)
          {
            i-=3*n;
          }
          quadrant_compoents();
        }
      }
    }

    {

      for (j=height/2+3*n; j <height; j+=3*n) {
        for (i=width/2-3*n; i >0; i-=3*n) {
          quadrant_compoents();
        }
      }
    }

    {

      for (j=height/2; j <height; j+=3*n) {
        for (i=width/2; i <width; i+=3*n) {
          quadrant_compoents();
        }
      }
    }
  }
}

void dots()
{

  stroke(c3);
  strokeWeight(1);
  point(i + spacer/2, j + spacer/2);
}


void plus_cross()
{ 
  smooth();
  stroke(c6);
  strokeWeight(t); 
  line(i-n, j-n, i+n, j+n);// up to down  
  line(i-n, j+n, i+n, j-n);// down to up
}

