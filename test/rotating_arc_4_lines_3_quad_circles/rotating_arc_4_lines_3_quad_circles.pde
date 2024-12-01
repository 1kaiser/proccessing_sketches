int i, j;

float an1=0, an2=15, h=90, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  //background(0, 73, 88, 40);
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  c_centre();
  icolour1=color(127, 255, 212, 20);
  icolour2=color(127, 170, 255, 5);

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
    ellipse(i+n*cos(ang1+rotation), j+n*sin(ang1+rotation), 2*dist (i, j, i+n*cos(ang1+rotation), j+n*sin(ang1+rotation)), 2*dist (i, j, i+n*cos(ang1+rotation), j+n*sin(ang1+rotation)));
    ellipse(i+n*cos(ang1+rotation+PI/2), j+n*sin(ang1+rotation+PI/2), 2*dist (i, j, i+n*cos(ang1+rotation+PI/2), j+n*sin(ang1+rotation+PI/2)), 2*dist (i, j, i+n*cos(ang1+rotation+PI/2), j+n*sin(ang1+rotation+PI/2)));
    ellipse(i+n*cos(ang1+rotation+PI), j+n*sin(ang1+rotation+PI), 2*dist (i, j, i+n*cos(ang1+rotation+PI), j+n*sin(ang1+rotation+PI)), 2*dist (i, j, i+n*cos(ang1+rotation+PI), j+n*sin(ang1+rotation+PI)));
    ellipse(i+n*cos(ang1+rotation+PI*3/2), j+n*sin(ang1+rotation+PI*3/2), 2*dist (i, j, i+n*cos(ang1+rotation+PI*3/2), j+n*sin(ang1+rotation+PI*3/2)), 2*dist (i, j, i+n*cos(ang1+rotation+PI*3/2), j+n*sin(ang1+rotation+PI*3/2)));
    rotation++;
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

  sentence="68";
  //font1=loadFont("AgencyFB-Bold-255.vlw");
  //textFont(//font1, 250*sqrt (2)*2);
  textAlign(CENTER, CENTER);
  fill(255, 255, 255, 150);
  noSmooth();
  text(sentence, i, j);

  sentence="INDEPENDENCE\nDAY\n\n";
  //font2=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  //textFont(//font2, 100);
  textAlign(CENTER, BOTTOM );
  fill(255);
  noSmooth();
  text(sentence, width/2, height);


  save("diagonal5.tif");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

