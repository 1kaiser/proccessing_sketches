int i, j;

float an1=0, an2=15, h=90, ang1=radians(an1), ang2=radians(an2), rotation=radians(h), tang, n;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  background(00, 0, 0, 40);
  size( 7860, 4320);
  c_centre();
  icolour1=color(255, 0, 0, 20);
  icolour2=color(255, 255, 255, 20);

  rotation=radians(h);
  for (n=0; n<dist (0, 0, i, j); n=n+500)
  {
    noStroke();
    //stroke(lerpColor(icolour1, icolour2, map(n, 0, dist (0, 0, i, j), 0, 1)));
    fill(lerpColor(icolour1, icolour2, map(n, 0, dist (0, 0, i, j), 0, 1)));
    //strokeWeight(1);
    noSmooth();
    //noFill();
    // arc(i, j, 2*n, 2*n, ang1+rotation, ang2+rotation, OPEN);
    // arc(i, j, 2*n, 2*n, ang1+rotation+PI, ang2+rotation+PI, OPEN);
    //line(i, j, i+n*cos(ang1+rotation), j+n*sin(ang1+rotation));
    //line(i, j, i+n*cos(ang1+rotation+PI), j+n*sin(ang1+rotation+PI));
    each_ellipse( n, ang1, rotation );
    //ellipse(i+n*cos(ang1+rotation), j+n*sin(ang1+rotation), 2*dist (i, j, i+n*cos(ang1+rotation), j+n*sin(ang1+rotation)), 2*dist (i, j, i+n*cos(ang1+rotation), j+n*sin(ang1+rotation)));
    //ellipse(i+n*cos(ang1+rotation+PI/2), j+n*sin(ang1+rotation+PI/2), 2*dist (i, j, i+n*cos(ang1+rotation+PI/2), j+n*sin(ang1+rotation+PI/2)), 2*dist (i, j, i+n*cos(ang1+rotation+PI/2), j+n*sin(ang1+rotation+PI/2)));
    //ellipse(i+n*cos(ang1+rotation+PI), j+n*sin(ang1+rotation+PI), 2*dist (i, j, i+n*cos(ang1+rotation+PI), j+n*sin(ang1+rotation+PI)), 2*dist (i, j, i+n*cos(ang1+rotation+PI), j+n*sin(ang1+rotation+PI)));
    //ellipse(i+n*cos(ang1+rotation+PI*3/2), j+n*sin(ang1+rotation+PI*3/2), 2*dist (i, j, i+n*cos(ang1+rotation+PI*3/2), j+n*sin(ang1+rotation+PI*3/2)), 2*dist (i, j, i+n*cos(ang1+rotation+PI*3/2), j+n*sin(ang1+rotation+PI*3/2)));
    rotation++;
  }


  save("diagonal5.tif");
}
void each_ellipse(float n, float ang1, float rotation )
{
  for (tang=0; tang<4; tang++)
  { 
    ellipse(i+n*cos(ang1+rotation+PI*tang/2), j+n*sin(ang1+rotation+PI*tang/2), 2*dist (i, j, i+n*cos(ang1+rotation+PI*tang/2), j+n*sin(ang1+rotation+PI*tang/2)), 2*dist (i, j, i+n*cos(ang1+rotation+PI*tang/2), j+n*sin(ang1+rotation+PI*tang/2)));
  }
}

void c_centre()// canvas centre 2089ff
{
  i=width/2;
  j=height/2;
}

