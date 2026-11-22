int l=100;
float a = 0.0, b = 8, i, j, k, m1=0, m2=0, m3;
float inc = radians(15), re=radians(30);
String   sentence="5";
PFont font1;

void setup() {
  //size( 7860, 4320);
  size( 8192 , 5120);
  background(220, 220, 220);
  stroke(35, 35, 35);
  noSmooth();
  strokeWeight(50);
  // section();//6

  k=width;

  //for (int i = 0; i < 5000; i=i+10) //1
  for (i = -l; i <width+l; i=i+l)
  {
    //line(i, height/2, i, height/2+sin(a)*height/20*9);  //2
    //point(i, height/2+sin(a)*height/20*9);//3
    //point(i, height/2+sin(b)*height/20*5);//4
    //point(i, height/2+sin(a)*height/20*9);//5
    // k--;
    i+=l/b;
    a = a + inc;
    for (j = 0; j < b; j++)
    {

      point(i, height/2+sin(a+re*j)*height/2*(k-i)/k*j/b);//5
    }
    //a = a + inc;
    //b=b+inc+re;//4
    //b=b+re;//5
  }
/*
  for (int n=0; n<250*sqrt (2); n++)
  {
     stroke(color(0, 0, 0, 200));
    strokeWeight(1);
    noFill();
    noSmooth();
    ellipse(width/2, height/2, 2*sqrt(2)*n, 2*sqrt(2)*n);//central circle
  }
*/
  

   fill(color(0, 0, 0, 240));
   noSmooth();
   ellipse(width/2, height/2, 2*sqrt(2)*250*sqrt (2), 2*sqrt(2)*250*sqrt (2));//central circle
  

  font1=loadFont("AgencyFB-Bold-255.vlw");
  textFont(font1, 250*sqrt (2)*2);
  textAlign(CENTER, CENTER);
  fill(255, 255, 255, 150);
  noSmooth();
  text(sentence, width/2, height/2);
  
  

  sentence="MY BEST\nWHAT'S YOURS\n";
  font1=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  textFont(font1, 100);
  textAlign(CENTER, BOTTOM );
  fill(255);
  noSmooth();
  text(sentence, width/2, height);

  save("lat-###4.tif");
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
