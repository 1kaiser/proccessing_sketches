int i, j;

float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;


void setup() 
{
  //background(255);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  c_centre();



  float n2=0;
  for (float n1=width/5; n1<=width; n1=n1+width/5)
  {
    if (n2==0)
    {  
      icolour1=color(255, 0, 0);
      icolour2=color(255, 255, 0);
    }
    if (n2==1)
    {  
      icolour1=color(0, 255, 0);
      icolour2=color(255, 255, 0);
    }
    if (n2==2)
    {  
      icolour1=color(0, 255, 0);
      icolour2=color(0, 255, 255);
    }
    if (n2==3)
    {  
      icolour1=color(0, 0, 255);
      icolour2=color(0, 255, 255);
    }
    if (n2==4)
    {  
      icolour1=color(0, 0, 255);
      icolour2=color(255, 0, 255);
    }
    n2++;
    for (n=180; n>0; n=n-.1)
    {
      noStroke();
      fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));

      noSmooth();
      arc(n1-width/10, j, .8*width/5, .8*width/5, PI/2 -radians(n), PI/2+radians(n), OPEN);
    }
  }

  save("diagonal5.png");
  save("diagonal5.tiff");
  save("diagonal5.jpeg");
}
void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

