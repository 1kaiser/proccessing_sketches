int l=500;
float a = 0.0, b = 8, i, j, k, m1=0, m2=0, m3;
float inc = radians(45), re=radians(90);
String   sentence="5";
//PFont //font;
//PImage //img;


void setup() {
  //size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  //size( 7860/3, 4320/3);//size( 8192/3, 5120/3);
  ////background(50);

  //img = loadImage("1 (7).jpg");

  size( 7860/3, 4320/3);//size( 7860*2, 4320*2);
  //image(//img, 0, 0, width, height);
  ////background(//img);
  noSmooth();


  sentence="SLNOV1_AGK";


  int no=0;
  float y0=2*min(width, height)/10;

  for (float y1=-0.5; y1<1; y1+=1)
  {

    for (float x1=-2; x1<3; x1+=1)

    { 



      // sentence=""+(++letters[no])+"";

      noSmooth();


      if (no==6) 
      {
        float siz=min(width, height)/35;
        //font=loadFont("AgencyFB-Bold-255.vlw");
        //textFont(//font, siz);
        textAlign(CENTER, CENTER);
        fill(255, 255, 0);
        int pos=0;
        for (float z1=-1.5; z1<2; z1+=1)
        {
          for (float z2=0; z2<1; z2+=1)
          { 
            String   sentence1="ZERO";
            text(sentence1.charAt(pos), width/2+x1*y0+z2*siz, height/2+y1*y0+z1*siz);
            pos++;
          }
        }
      }
      //font=loadFont("AgencyFB-Bold-255.vlw");
      //textFont(//font, min(width, height)/8);
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


  save("lat-###f.jpg");
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
