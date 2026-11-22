int l=500;
float a = 0.0, b = 8, i, j, k, m1=0, m2=0, m3;
float inc = radians(45), re=radians(90);
String   sentence="5";
PFont font;
PImage img;


void setup() {
  size( 7860, 4320);
  // size( 8192, 5120);
  background(255);

  noSmooth();


  float y0=min(width, height)/15;
  noStroke();
  // fill(255, 50, 50);
  //rect(width*.4-4, height*.3-4, width*1-2*(width*.4-4), height*.32+2*4, min(width, height)/50);
  fill(255, 100, 100);
  rect(width*.4, height*.3, width*1-2*width*.4, height*.32, min(width, height)/50);
  fill(210);
  rect(width*.4, height*.4, width*1-2*width*.4, height-2* height*.4, 0);
  sentence="17NOV";
  int no=0;
  float n1=.5, n2=.5;
  for (float y1=0; y1<1; y1+=1)
  {

    for (float x1=-2; x1<3; x1+=1)

    { 
      font=loadFont("DIN-Light-255.vlw");
      textFont(font, min(width, height)/10);
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
