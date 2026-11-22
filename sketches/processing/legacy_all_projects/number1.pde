int l=500;
float a = 0.0, b = 8, i, j, k, m1=0, m2=0, m3;
float inc = radians(45), re=radians(90);
String   sentence="5";
PFont font;
PImage img;


void setup() {
  size( 7860, 4320);
  //size( 8192, 5120);
  background(100);

  noSmooth();


  float y0=min(width, height)/10;
  noStroke();
  fill(0, 255, 130);
  rect(width*.225, height*.3, width*1-2*width*.225, height*.32, min(width, height)/50);
  fill(240);
  rect(width*.225, height*.4, width*1-2*width*.225, height-2* height*.4, 0);
  sentence="1P6681XZK";
  int no=0;
  float n1=.5, n2=.5;
  for (float y1=0; y1<1; y1+=1)
  {

    for (float x1=-4; x1<5; x1+=1)

    { 
      font=loadFont("DIN-Light-255.vlw");
      textFont(font, min(width, height)/8);
      textAlign(CENTER, CENTER);
      fill(50);
      text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
      no++;
    }
  }



  save("lat-###f.png");
}
/*void section()   //6
 {
 m1=random(0, width);
 m2=random(0, width);
 while (m1==0||m2==0|| (max (m1, m2)-min(m1, m2))<5*l|| (max (m1, m2)-min(m1, m2))>7*l  )
 {
 section();
 }
 m3=max(m1, m2);
 m1=min(m1, m2);
 }
 */
