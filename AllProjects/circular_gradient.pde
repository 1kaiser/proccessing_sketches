color icolour, icolour1, icolour2;
int i, j, n;
String sentence="AMBIANCE";
PFont font;
void setup() 
{
  background(255);
  size( 7860, 4320);
  c_centre();
  icolour1=color(255, 0, 0, 100);
  icolour2=color(255, 255, 0, 100);

  for (n=0; n<dist (0, 0, i, j); n+=5)
  {

    stroke(lerpColor(icolour1, icolour2, map(n, 0, 2*dist(0, 0, i, j), 0, 1)));
    strokeWeight(7);
    noFill();
    noSmooth();
    ellipse(i, j, 2*n, 2*n);//central circle
  }

  font=loadFont("ArialRoundedMTBold-255.vlw");
  textFont(font, 500);
  textAlign(CENTER, CENTER);
  fill(255, 0, 50, 200);
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


      stroke(color(130, 255, 0));
      strokeWeight(10);
      fill(color(50, 255, 0));
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


  save("diagonal2.tif");
}
void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

