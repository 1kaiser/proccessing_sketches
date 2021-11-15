int i, j, spacer=10, fs=500, //font size 
n=10, //length of plus 
t=1;//strokewidth for plus sign
float p;
PFont font;

String sentence="ARRIVING";//text in the output 
color  c1= color(255, 192, 65), //background upper gradient 
c2= color(255, 65, 65), //background lower gradient 
c3= color(144, 79, 144), //dot colour 
c5= color(88, 172, 255, 200), //text colour 
c6= color(255, 255, 255, 100);// plus colour 




void setup()
{

  background(0);
  size(7860, 4320);
  //setGradient(0, 0, width, height, c1, c2);// background 
  quadrants();// design of background 
  texts();// text conveyed 

  sentence="THINK ON YOUR SINS\n14.139.241.84\n";
  font=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  textFont(font, 100);
  textAlign(CENTER, BOTTOM );
  fill(255);
  noSmooth();
  text(sentence, width/2, height);
  save("diagonal2.tif");
}
//23.2143771,77.4140177

void quadrant_compoents()
{
  plus();
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
void co_ordinates()
{
  i=width/2;
  j=height/2;
}
void texts()
{
  //font=loadFont("HelveticaNeue-CondensedBold-255.vlw");
  font=loadFont("ArialRoundedMTBold-255.vlw");
  textFont(font, fs);
  co_ordinates();
  textAlign(CENTER, CENTER);
  fill(c5);
  noSmooth();
  text(sentence, i, j);
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


void plus()
{ 
  stroke(c6);
  strokeWeight(t); 
  line(i, j-n, i, j+n+1);// vertical 
  line(i-n, j, i+n+1, j);// horizontal
}

