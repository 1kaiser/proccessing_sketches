int i, j;

float an1=15, an2=15, an=0, h=90, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n=radians(an);
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  background(255, 255, 255, 20);
  size( 7860, 4320);
  c_centre();
  icolour1=color(255, 255, 0, 100);
  icolour2=color(255, 128, 0, 150);

  rotation=radians(h);
  int n1=0;
  for (n= 0; n<2*PI-ang1; n=n+ang1)
    for (int k=0; k<2; k++)
    {  
      for (int l=0; l<2; l++)
      { 

        {
          noStroke();
          //stroke(lerpColor(icolour1, icolour2, map(n, 0, dist (0, 0, i, j), 0, 1)));
          if (n<=2*PI&&n>3*PI/2)
          {
            n1=4;
          }
          if (n>PI&&n<3*PI/2)
          {
            n1=3;
          }
          if (n>PI/2&&n<PI)
          {
            n1=2;
          }
          if (n>=0&&n<PI/2)
          {
            n1=1;
          }
          fill(lerpColor(icolour1, icolour2, map(abs((2*n1-1)*PI/4-n), 0, PI/4, 0, 1)));
          //strokeWeight(1);
          noSmooth();
          //noFill();
          arc(l*width, k*height, 2*dist (0, 0, width, height), 2*dist (0, 0, width, height), n, n+ang1, PIE);
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


  save("diagonal7.tif");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

