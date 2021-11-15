int i, j;

float an1=15, an2=15, h=1, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), C=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  background(255);
  //size( 7860, 4320);
  size(  8192,5120 );
  c_centre();
  icolour1=color(0, 0, 0);
  icolour2=color(255, 255, 255);

  for (n=0; n<dist (0, 0, i, j); n=n+h)
  {
    stroke(lerpColor(icolour1, icolour2, map(n, 0, dist (0, 0, i, j), 0, 1)));
    //fill(lerpColor(icolour1, icolour2, map(n, 0, dist (0, 0, i, j), 0, 1)));
    strokeWeight(h);
    noSmooth();
    // arc(i, j, 2*n, 2*n, ang1+rotation, ang2+rotation, OPEN);
    // arc(i, j, 2*n, 2*n, ang1+rotation+PI, ang2+rotation+PI, OPEN);
    line(i+n, j-height, i+n, j+height);
    line(i-n-h, j-height, i-n-h, j+height);
    line(i-width, j+n, i+width, j+n);
    line(i-width, j-n-h, i+width, j-n-h);
  }
  /*
  icolour=color(255);
   for (n=0; n<250*sqrt (2); n++)
   {
   
   stroke(icolour);
   strokeWeight(1);
   noFill();
   noSmooth();
   ellipse(i, j, 2*sqrt(2)*n, 2*sqrt(2)*n);//central circle
   }
   */
  sentence="FALL";
  font1=loadFont("ArialRoundedMTBold-255.vlw");
  textFont(font1, 500);
  textAlign(CENTER, CENTER);
  fill(255, 255, 255);
  noSmooth();
  text(sentence, i, j);

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


      stroke(color(150, 100, 50));
      strokeWeight(10);
      fill(color(200, 100, 100));
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


  save("diagonal6.tif");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

