int l=100, p=500, c1=1, i1=5, i2;
float a=1, b=100, i, k, j=20, m1=0, m2=0, m3, n;
float inc = radians(15), re=radians(30);
String   sentence="5";
PFont font1;
color c;
void setup() 
{
  PImage img;

  img = loadImage("diagonal15.tif");
  size( img.width, img.height);
  background(img);
  // filter(BLUR, 40);
  /*  stroke(35, 35, 35, 200);
   noSmooth();
   strokeWeight(1);
   strokeCap(PROJECT);
   if ((width/2)!=0)
   {
   i2=i1;
   } 
   if ((width/2)==0) {
   i2=0;
   }
   for (n=width/2; n>=-i1; n-=i1)
   {
   line(n-i2, height/2+p, n-i2, height/2-p);
   line(width/2+n+i2, height/2+p, width/2+n+i2, height/2-p);
   }
   */
  char[] letters = { 
    // 'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y'
    5, 2, 4, 7, 3, 7, 7, 6, 9
  };
  int no=0;
  float y0=2*dist(0, 0, img.width, img.height)/15;
  for (float y1=-y0; y1<=y0; y1+=y0)
  {

    for (float x1=-y0; x1<=y0; x1+=y0)

    { 
      c_centre();
      stroke(35, 35, 35);
      noSmooth();
      strokeWeight(50);

      fill(color(0, 0, 0, 200));
      noSmooth();
      // ellipse(width/2, height/2, 2*sqrt(2)*250*sqrt (2), 2*sqrt(2)*250*sqrt (2));//central circle
      stroke(color(0, 0, 0, 200));
      // strokeWeight(1);
      // noFill();
      noStroke();
      fill(color(0, 0, 0, 150));
      noSmooth();
      //noSmooth();
      /*      for (float n=0; n<dist (0, 0, img.width, img.height)/20; n++)
       {
       ellipse(i+x1, j+y1, 2*n, 2*n);//central circle
       }
       */      ellipse(i+x1, j+y1, 2*dist(0, 0, img.width, img.height)/20, 2*dist(0, 0, img.width, img.height)/20);
      stroke(255);
      int c=20;
      strokeWeight(c);
      noFill();
      c_centre();
      // ellipse(i, j, 2*sqrt(2)*250*sqrt (2), 2*sqrt(2)*250*sqrt (2));
      ellipse(i+x1, j+y1, 2*dist(0, 0, img.width, img.height)/20-sqrt (2)*c, 2*dist(0, 0, img.width, img.height)/20-sqrt (2)*c);


      sentence=""+int(letters[no])+"";
      no++;
      font1=loadFont("AgencyFB-Bold-255.vlw");
      textFont(font1, dist(0, 0, img.width, img.height)/13);
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      noSmooth();
      c_centre();
      text(sentence, i+x1, j+y1);
    }
  }

  sentence="BETTER\n\n";
  font1=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  textFont(font1, dist(0, 0, img.width, img.height)/90);
  textAlign(CENTER, BOTTOM );
  fill(0);
  noSmooth();
  text(sentence, width/2, height);

  save("diagonal15d.tif");
}

void c_centre()// canvas centre 2089ff
{
  i=width/2;
  j=height/2;
}

