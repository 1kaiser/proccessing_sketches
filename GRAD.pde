int l=500;
float a = 0.0, b = 8, i, j, k, m1=0, m2=0, m3;
float inc = radians(45), re=radians(90);
String   sentence="5";
PFont font;
float n1, n2;
void setup() {
  size( 7860, 4320);
  //size( 8192, 5120);
  background(50);
  stroke(0, 255, 255);
  noSmooth();
  strokeWeight(20);
  n1=.6; 
  n2=.7;
  color icolour2=color(0, 130, 255);
  color icolour1=color(255, 255, 255);

  for (float n=0; n<1.1*dist (0, 0, width, height); n+=1)
  {

    stroke(lerpColor(icolour1, icolour2, map(n, 0, 1.1*dist (0, 0, width, height), 0, 1)));
    strokeWeight(2);
    noFill();
    noSmooth();
    ellipse(n1*width, n2*height, 2*n, 2*n);//central circle
  }


  sentence="SIMPLE";

  int no=0;
  float y0=2*min(width, height)/30;

  for (float y1=-.5; y1<1; y1+=1)
  {

    for (float x1=-1; x1<2; x1+=1)

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
            text(sentence1.charAt(pos), n1*width+x1*y0+z2*150, n2*height+y1*y0+z1*150);
            pos++;
          }
        }
      }
      font=loadFont("AgencyFB-Bold-255.vlw");
      textFont(font, min(width, height)/20);
      textAlign(CENTER, CENTER);
      fill(255, 215, 0);
      if (no==6) 
      {
        fill(255, 0, 0);
      }
      text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
      no++;
    }
  }
  float y11=min(width, height)/8;

  float s1=y11;
  noFill();
  stroke(255, 0, 0, 200);
  strokeWeight(50); 
  strokeJoin(MITER);
  noSmooth();
  beginShape();
  for (float n=0; n<360; n=n+60)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    vertex(a1, a2);///
  }

  endShape(CLOSE);

  save("lat-###4.png");
}

