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
  icolour1=color(255, 255, 255, 1);
  icolour2=color(0, 0, 0, 1);

  ang1=dist (0, 0, width, height)/40;
  for (n= 0; n<dist (0, 0, width, height); n=n+ang1)
    for (int k=0; k<2; k++)
    {  
      for (int l=0; l<2; l++)
      { 

        {
          noStroke();

          fill(lerpColor(icolour2, icolour1, map(n, 0, dist (0, 0, width, height), 0, 1)));
          //strokeWeight(1);
          noSmooth();
          //noFill();
          ellipse(l*width, k*height, 2*n, 2*n);
        }
      }
    }


  icolour=color(0, 0, 0, 240);
  for (n=0; n<250*sqrt (2); n++)
  {

    stroke(icolour);
    strokeWeight(1);
    noFill();
    noSmooth();
    ellipse(i, j, 2*sqrt(2)*n, 2*sqrt(2)*n);//central circle
  }

  sentence="5";
  font1=loadFont("AgencyFB-Bold-255.vlw");
  textFont(font1, 250*sqrt (2)*2);
  textAlign(CENTER, CENTER);
  fill(255, 255, 255, 150);
  noSmooth();
  text(sentence, i, j);

  sentence="THINK ON YOUR SINS\n14.139.241.84\n";
  font2=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  textFont(font2, 100);
  textAlign(CENTER, BOTTOM );
  fill(255);
  noSmooth();
  text(sentence, width/2, height);


  save("diagonal10.tif");
  save("diagonal10.png");
  save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

