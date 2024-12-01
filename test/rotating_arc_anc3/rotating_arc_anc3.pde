int i, j;

float  ang1=0, ang2, tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  //background(255, 255, 255, 255);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  c_centre();
  icolour1=color(0, 100, 255, 100);
  icolour2=color(255, 255, 255, 10);

  ang1=dist (0, 0, width, height)/500;
  for (n= 0; n<dist (0, 0, width, height); n=n+ang1)
    for (int k=0; k<2; k++)
    {  
      for (int l=0; l<2; l++)
      { 

        {


          stroke(lerpColor(icolour2, icolour1, map(n, 0, dist (0, 0, width, height), 0, 1)));
          strokeWeight(ang1);
          noSmooth();
          noFill();
          arc(l*width, k*height, 2*n, 2*n, 0, 2*PI);
        }
      }
    }


  sentence="CHANGE";
  //font1=loadFont("ArialRoundedMTBold-255.vlw");
  //textFont(//font1, 500);
  textAlign(CENTER, CENTER);
  fill(0, 190, 255, 250);
  noSmooth();
  text(sentence, i, j);
  sentence="\n\n\n\n  ";
  //font1=loadFont("HelveticaNeue-UltraLight-255.vlw");
  //textFont(//font1, 200);
  textAlign(CENTER, TOP);
  fill(0, 0, 150, 250);
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


      stroke(color(0, 200, 100));
      strokeWeight(10);
      fill(color(0, 255, 150));
      noSmooth();
      ellipse(i+x1, j+y1, 2*y2/20, 2*y2/20);

      sentence=""+letters[no]+"";
      no++;
      //font=loadFont("AgencyFB-Bold-255.vlw");
      //textFont(//font, y2/13);
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      noSmooth();

      text(sentence, i+x1, j+y1);
    }
  }

  save("diagonal10.tif");
  // save("diagonal10.png");
  // save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}
