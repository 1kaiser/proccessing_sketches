int i, j, s/*spacer for heart*/, spacer=10, fs=500/*font size */, 
n=9/*length of plus */;
float p;
PFont font;
String sentence="HELLO";//text in the output 
color  c1= color(255, 192, 65), //background upper gradient 
c2= color(255, 65, 65), //background lower gradient 
c3= color(144, 79, 144), //dot colour 
c4= color(105, 142, 225, 50), //heart colour 
c5= color(59, 229, 59, 200), //text colour 
c6= color(59, 229, 59, 200);// plus colour 




void setup()
{


  size(7860, 4320);
  setGradient(0, 0, width, height, c1, c2);// background 
  quadrants();// design of background 
  heart();// centre design 
  texts();// text conveyed 
  save("diagonal.tif");
}


void quadrant_compoents()
{
  plus();
  dots();
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


void heart()
{
  s=900;
  p=s*sqrt(2);
  co_ordinates();

  noSmooth();
  noStroke();
  fill(c4);
  quad(i, j-s, i+s, j, i, j+s, i-s, j);
  arc(i-s/2, j-s/2, p, p, PI-QUARTER_PI, TWO_PI-QUARTER_PI);//left arc: arc(a, b, c, d, start, stop, mode);
  arc(i+s/2, j-s/2, p, p, PI+QUARTER_PI, TWO_PI+QUARTER_PI);//right arc
}


void texts()
{
  font=loadFont("HelveticaNeue-CondensedBold-255.vlw");
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

      for (j=height/2; j >0; j-=3*n) {
        for (i=width/2; i <width; i+=3*n) {
          quadrant_compoents();
        }
      }
    }

    {

      for (j=height/2; j >0; j-=3*n) {
        for (i=width/2; i >0; i-=3*n) {
          quadrant_compoents();
        }
      }
    }

    {

      for (j=height/2; j <height; j+=3*n) {
        for (i=width/2; i >0; i-=3*n) {
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
  strokeWeight(1); 
  line(i, j-n, i, j+n);
  line(i-n, j, i+n, j);
}

