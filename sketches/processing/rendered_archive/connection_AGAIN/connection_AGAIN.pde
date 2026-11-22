int i, j;

float  ang1=0, ang2, tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  //background(50);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  c_centre();
  icolour1=color(0, 0, 0, 100);
  icolour2=color(0, 0, 0);



  icolour2=color(150, 150, 150);
  icolour1=color(255, 255, 255);

  for (n=0; n<dist (0, 0, width, height); n+=1)
  {

    stroke(lerpColor(icolour1, icolour2, map(n, 0, 2*dist(0, 0, i, j), 0, 1)));
    strokeWeight(2);
    noFill();
    noSmooth();
    ellipse(width/2, height/2, 2*n, 2*n);//central circle
  }



  float n1=.5, n2=.5;



  icolour1=color(0, 255, 130);
  icolour2=color(0, 0, 255);
  color icolour3=color(255, 255, 0);
  color icolour4=color(255, 0, 255);
  float rad=.3*height;

  for (n=180; n>0; n=n-.1)
  {


    noSmooth();
    noFill();
    stroke(255);
    strokeWeight(20);
    arc(n1*width, n2*height, rad-30, rad-30, PI/2-PI/2 -radians(n), PI/2-PI/2+radians(n), OPEN);
    stroke(0);
    strokeWeight(2);
    arc(n1*width, n2*height, rad+90, rad+90, PI/2-PI/2 -radians(n), PI/2-PI/2+radians(n), OPEN);
    stroke(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
    strokeWeight(40);
    arc(n1*width, n2*height, rad, rad, PI/2-PI/2 -radians(n), PI/2-PI/2+radians(n), OPEN);

    // rotation++;
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

