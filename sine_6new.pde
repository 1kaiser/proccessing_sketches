int l=500;
float a = 0.0, b = 8, i, j, k, m1=0, m2=0, m3;
float inc = radians(45), re=radians(90);
String   sentence="5";
PFont font;

void setup() {
  size( 7860, 4320);
  //size( 8192, 5120);
  background(50);
  stroke(0, 255, 255);
  noSmooth();
  strokeWeight(20);
  // section();//6

  k=width;

  //for (int i = 0; i < 5000; i=i+10) //1
  for (i = width/2; i <width; i=i+l)
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

      point(i, height/2+sin(a+re*j)*height/4);//5
      point(width-i, height/2+sin(a+re*j)*height/4);//5
    }
    //a = a + inc;
    //b=b+inc+re;//4
    //b=b+re;//5
  }



  sentence="SLNOV1_AGK";


  int no=0;
  float y0=2*dist(0, 0, width, height)/20;

  for (float y1=-0.5; y1<1; y1+=1)
  {

    for (float x1=-2; x1<3; x1+=1)

    { 



      // sentence=""+(++letters[no])+"";

      noSmooth();


      if (no==6) 
      {
        font=loadFont("AgencyFB-Bold-255.vlw");
        textFont(font, 150);
        textAlign(CENTER, CENTER);
        fill(255, 255, 0);
        int pos=0;
        for (float z1=-1.5; z1<2; z1+=1)
        {
          for (float z2=0; z2<1; z2+=1)
          { 
            String   sentence1="ZERO";
            text(sentence1.charAt(pos), width/2+x1*y0+z2*150, height/2+y1*y0+z1*150);
            pos++;
          }
        }
      }
      font=loadFont("AgencyFB-Bold-255.vlw");
      textFont(font, dist(0, 0, width, height)/15);
      textAlign(CENTER, CENTER);
      fill(255);
      if (no==6) 
      {
        fill(255, 0, 0);
      }
      text(sentence.charAt(no), width/2+x1*y0, height/2+y1*y0);
      no++;
    }
  }


  save("lat-###4.png");
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
