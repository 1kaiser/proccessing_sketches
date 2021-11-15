float i, j, spacer=10, fs=900, //font size 
n=10, //length of plus 
t=1, //strokeimg.width for plus sign
p;
PFont font;

String sentence="HAPPY\nRAINS";//text in the output 
color  c1= color(255, 0, 0, 100), //background upper gradient 
c2= color(0, 0, 255, 100), //background lower gradient 
c3= color(0), //dot colour 
c5= color(49, 164, 255, 200), //text colour 
c6= color(255, 255, 255, 50);// plus colour 
/*c1= color(0, 82, 131), //background upper gradient 
 c2= color(0, 159, 255), //background lower gradient 
 */



PImage img;


void setup()
{

  // background(0, 112, 201, 150);
  //img=loadImage("IMG_20140914_131831.jpg");
  // size( 7860,4320 );
  // size(  5120, 8192 );
  img = loadImage("vgb.jpg");
  size(  img.width, img.height );
  background(img);
  filter(THRESHOLD, 0.141);

  // setGradient(0, 0, img.width, img.height, c1, c2);
  int diameter=6;
  for (int gy=0; gy<img.height; gy+=5)
  {

    for (int gx=0; gx<img.width; gx+=5)

    {
      color copy = get(gx, gy);
      float r1 = red(copy);  
      float r2 = green(copy);  
      float r3 = blue(copy);  
      float r4 = alpha(copy);  
      stroke(r1, r2, r3);
      strokeWeight(diameter);
      ellipse(gx, gy, diameter, diameter);
    }
  }
  updatePixels();
  //setGradient(0, 0, img.width, img.height, c1, c2);// background 


  char[] letters = { 
    //  'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y', 
    5, 2, 4, 7, 3, 7, 7, 6, 9
  };

  int no=0;
  /*  float y0=2*dist(0, 0, img.width, img.height)/15;
   
   for (float y1=-y0; y1<=y0; y1+=y0)
   {
   
   for (float x1=-y0; x1<=y0; x1+=y0)
   
   { 
   
   
   
   // sentence=""+(++letters[no])+"";
   sentence=""+(++letters[no])+"";
   no++;
   font=loadFont("AgencyFB-Bold-255.vlw");
   textFont(font, dist(0, 0, img.width, img.height)/13);
   textAlign(CENTER, CENTER);
   fill(255, 255, 255);
   noSmooth();
   text(sentence, img.width/2+x1, img.height/2+y1);
   }
   }
   */
  //int no=0;
  float i=img.width*.90;
  float j=img.height/2;//-img.width*.10;
  float y2=min(img.width, img.height)/5*sqrt(2);
  float y0=2*y2/15;
  for (float y1=-y0; y1<=y0; y1+=y0)
  {

    for (float x1=-y0; x1<=y0; x1+=y0)

    { 

      stroke(35, 35, 35);
      noSmooth();
      strokeWeight(50);

      fill(color(0, 0, 0, 200));
      noSmooth();
      // ellipse(img.width/2, img.height/2, 2*sqrt(2)*250*sqrt (2), 2*sqrt(2)*250*sqrt (2));//central circle
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
       */      ellipse(i+x1, j+y1, 2*y2/20, 2*y2/20);
      /*    stroke(255);
       
       strokeWeight(y2/225);
       noFill();
       
       // ellipse(i, j, 2*sqrt(2)*250*sqrt (2), 2*sqrt(2)*250*sqrt (2));
       ellipse(i+x1, j+y1, (2/20-sqrt (2)/225)*y2, (2/20-sqrt (2)/225)*y2);
       
       */
      sentence=""+int(letters[no])+"";
      no++;
      font=loadFont("AgencyFB-Bold-255.vlw");
      textFont(font, y2/13);
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      noSmooth();

      text(sentence, i+x1, j+y1);
    }
  }
  sentence="BETTER\n\n";
  font=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  textFont(font, dist(0, 0, img.width, img.height)/90);
  textAlign(CENTER, BOTTOM );
  fill(255);
  noSmooth();
  text(sentence, img.width/2, img.height);


  save("IMG_20140914_131831c.jpg");
}
//23.2143771,77.4140177

void setGradient(int x, int y, float w, float h, color c1, color c2)
{


  noFill();

  {  // Top to bottom gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      noSmooth();
      line(i, y, i, y+h);
    }
  }
}

