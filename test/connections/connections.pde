int i, j;

float  ang1=0, ang2, tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  //background(220);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  c_centre();
  icolour1=color(0, 0, 0, 100);
  icolour2=color(0, 0, 0);



  float n1=.5, n2=.5;



  icolour1=color(0, 255, 130);
  icolour2=color(0, 0, 255);
  color icolour3=color(255, 255, 0);
  color icolour4=color(255, 0, 255);
  float rad=.3*height;
  float g=45;
  for (n=180; n>0; n=n-.1)
  {
    noStroke();
    //strokeWeight(50);
    noSmooth();
    noFill();
    fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    if (n<=60)
    {
      fill(220);
    }
    arc(n1*width-rad/4-.5, n2*height, rad, rad, -2*PI -radians(n), -2*PI+radians(n), OPEN);
    fill(lerpColor(icolour3, icolour4, map(n, 0, 180, 0, 1)));
    if (n<=60)
    {
      fill(220);
    }
    arc(n1*width+rad/4+.5, n2*height, rad, rad, PI -radians(n), PI+radians(n), OPEN);
    noFill();
    stroke(255);
    strokeWeight(8);
    arc(n1*width, n2*height, 3*rad/2+100-8, 3*rad/2+100-8, -PI/2 -radians(n), -PI/2+radians(n), OPEN);
    stroke(0);
    strokeWeight(4);

    arc(n1*width, n2*height, 3*rad/2+100, 3*rad/2+100, -PI/2 -radians(n), -PI/2+radians(n), OPEN);

    // rotation++;
  }


  //save("diagonal10.tif");
  save("diagonal15.png");
  //save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

