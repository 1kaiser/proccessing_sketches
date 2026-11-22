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

  ang1=dist (0, 0, width, height)/100;
  for (n= 0; n<dist (0, 0, width, height); n=n+ang1)
    for (int k=0; k<2; k++)
    {  
      for (int l=0; l<2; l++)
      { 

        {


          stroke(lerpColor(icolour2, icolour1, map(n, 0, dist (0, 0, width, height), 0, 1)));
          strokeWeight(100);
          noSmooth();
          noFill();
          arc(l*width, k*height, 2*n, 2*n, 0, 2*PI);
        }
      }
    }




  sentence=" ";
  //font1=loadFont("HelveticaNeue-UltraLight-255.vlw");
  //textFont(//font1, 250);
  textAlign(CENTER, CENTER);
  fill(0, 40, 255, 250);
  noSmooth();
  text(sentence, i, j);



  save("diagonal10.tif");
  // save("diagonal10.png");
  // save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}
