int i, j;

float  ang1=0, ang2, tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  background(255);
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
      fill(lerpColor(icolour3, icolour4, map(n, 0, 180, 0, 1)));
    }
    arc(n1*width-rad/4-.5, n2*height, rad, rad, -2*PI -radians(n), -2*PI+radians(n), OPEN);
    fill(lerpColor(icolour3, icolour4, map(n, 0, 180, 0, 1)));
    if (n<=60)
    {
      fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
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
  n1=.5; 
  n2=.5;
  heart(n1*width, n2*height);
  //save("diagonal10.tif");
  save("diagonal15.png");
  //save("diagonal10.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

void heart(float q1, float q2)
{
  color icolour1=color(255, 50, 200);
  color icolour2=color(255, 50, 50);
  float p=2*min(width, height)/30;
  float s=p/sqrt(2);
  noSmooth();
  noStroke();
  fill(255, 50, 50);
  quad(q1, q2-s, q1+s, q2, q1, q2+s, q1-s, q2);
  for (float v=90; v>0; v=v-.1)
  {

    noStroke();
    noSmooth();
    fill(lerpColor(icolour1, icolour2, map(v, 0, 90, 0, 1)));
    arc(q1-s/2, q2-s/2, p, p, PI+PI/4-radians(v), PI+PI/4+radians(v), OPEN);
    arc(q1+s/2, q2-s/2, p, p, -PI/4-radians(v), -PI/4+radians(v), OPEN);
  }
}

