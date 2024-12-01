int l=500;
float a = 0.0, b = 8, i, j, k, m1=0, m2=0, m3;
float inc = radians(45), re=radians(90);
String   sentence="5";
//PFont //font;
float n1, n2;
//PImage //img;
float cal;

void setup() {
  //img = loadImage("Intelligent-Woman-Thinking.jpg");

  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  //background(//img);

  n1=.8; 
  n2=.7;

  sentence="UNCERTAIN";
  cal=1;
  SENT();




  save("Intelligent-Woman-Thinkingsae1.png");
}

void SENT()
{
  float y11=min(width, height)/5;

  float s1=y11;
  noFill();
  stroke(50, 30, 255, 180);
  strokeWeight(min(width, height)/60); 
  strokeJoin(MITER);
  noSmooth();
  fill(0, 0, 0, 150);
  beginShape();
  for (float n=45/2; n<360; n=n+45)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    vertex(a1, a2);///
  }
  endShape(CLOSE);

  int no=0;
  float y0=2*min(width, height)/25;


  for (float y1=-1; y1<2; y1+=1)
  {

    for (float x1=-1; x1<2; x1+=1)

    { 



      // sentence=""+(++letters[no])+"";

      noSmooth();

      /*
      if (no==6) 
       {
       //font=loadFont("AgencyFB-Bold-255.vlw");
       //textFont(//font, 150);
       textAlign(CENTER, CENTER);
       fill(255, 255, 0);
       int pos=0;
       for (float z1=-1.5; z1<2; z1+=1)
       {
       for (float z2=0; z2<1; z2+=1)
       { 
       String   sentence1="ZERO";
       text(sentence1.charAt(pos), n1*width+x1*y0+z2*150, n2*height+y1*y0+z1*150);
       pos++;
       }
       }
       }
       */
      //font=loadFont("LHFOldBlockCondMed-255.vlw");
      //textFont(//font, min(width, height)/18);
      textAlign(CENTER, CENTER);
      if (cal==0 || cal==1)
      {
        fill(255, 120, 30);//255, 215, 0);
      }
      if (cal==1)
      {
        if (no<8 && no>=0 ) 
        {
          fill(255, 150, 30);
        }
        if (no>=8 ) 
        {
          fill(255, 30, 60);
        }
      }

      text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
      no++;
    }
  }
}

