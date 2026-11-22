int i, j, s/*spacer for heart*/, spacer=10, fs=600/*font size */;
float p;
PFont font;
String sentence="HELLO";//text in the output 
color  c1= color(255, 192, 65), //background upper gradient 
c2= color(255, 65, 65), //background lower gradient 
c3= color(144, 79, 144), //dot colour 
c4= color(105, 142, 225, 50), //heart colour 
c5= color(59, 229, 59, 200); //text colour 





void setup()
{


  size(7860, 4320);
  setGradient(0, 0, width, height, c1, c2);
  dots();
  heart();
  texts();
  save("diagonal.tif");
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

void dots()
{

  for (int y =  0; y < height; y+=spacer) {
    for (int x= 0; x < width; x+=spacer) {
      noSmooth();

      stroke(c3);
      strokeWeight(1);
      point(x + spacer/2, y + spacer/2);
    }
  }
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

