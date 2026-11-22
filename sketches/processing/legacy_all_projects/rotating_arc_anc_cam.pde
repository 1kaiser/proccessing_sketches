int i, j;

float  ang1=0, ang2, tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  background(255, 255, 255, 255);
  size( 7860, 4320);
  c_centre();
  icolour1=color(0, 0, 0, 100);
  icolour2=color(0, 0, 0);

  ang1=dist (0, 0, width, height)/40;


  float n1=-.4, n2=-.4;

  n=dist (0, 0, width, height)*.4;
  float n3=dist (n1*width, n2*height, i, j);
  strokeWeight(n);
  stroke(255, 0, 0);
  noSmooth();
  noFill();
  ellipse(n1*width, n2*height, 2*n3, 2*n3);
  float n4=300;
  strokeWeight(n4);
  ellipse(n1*width, n2*height, 2*n3+n+2*n4, 2*n3+n+2*n4);

  /*

   icolour=color(0, 0, 0, 240);
   for (n=0; n<250*sqrt (2); n++)
   {
   
   stroke(icolour);
   strokeWeight(1);
   noFill();
   noSmooth();
   ellipse(i, j, 2*sqrt(2)*n, 2*sqrt(2)*n);//central circle
   }
   stroke(color(255));
   noFill();
   strokeWeight(100);
   ellipse(i, j, 2*sqrt(2)*n+500, 2*sqrt(2)*n+500);
   
   
   
   sentence="5";
   font1=loadFont("AgencyFB-Bold-255.vlw");
   textFont(font1, 250*sqrt (2)*2);
   textAlign(CENTER, CENTER);
   fill(255, 255, 255, 150);
   noSmooth();
   text(sentence, i, j);
   
   */


  char[] letters = { 
    //  'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y', 
    // 5, 2, 4, 7, 3, 7, 7, 6, 9
    'K', '2', '4', '7', 'E', '7', '7', '6', 'Y',
  };

  int no=0;

  float i=width*.50;
  float j=height*.90;
  float y2=min(width, height)/5*sqrt(2);
  float y0=2*y2/15;
  for (float y1=-y0; y1<=y0; y1+=y0)
  {

    for (float x1=-y0; x1<=y0; x1+=y0)

    { 


      stroke(color(255, 130, 100));
      strokeWeight(10);
      fill(color(255, 130, 0));
      noSmooth();
      ellipse(i+x1, j+y1, 2*y2/20, 2*y2/20);

      sentence=""+letters[no]+"";
      no++;
      font=loadFont("AgencyFB-Bold-255.vlw");
      textFont(font, y2/13);
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      noSmooth();

      text(sentence, i+x1, j+y1);
    }
  }


  //save("diagonal10.tif");
  save("diagonal10.png");
  //save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

