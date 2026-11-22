int i, j, n;

float an1=0, an2=15, h=1, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  background(255);
  size( 7860, 4320);
  c_centre();
  icolour1=color(246, 246, 246, 200);
  icolour2=color(74, 74, 74, 200);

  rotation=radians(h);
  for (n=0; n<dist (0, 0, i, j); n=n+1)
  {
    noStroke();
    fill(lerpColor(icolour1, icolour2, map(n, 0, dist (0, 0, i, j), 0, 1)));
    strokeWeight(50);
    noSmooth();
    arc(i, j, 2*n, 2*n, ang1+rotation, ang2+rotation, OPEN);
    arc(i, j, 2*n, 2*n, ang1+rotation+PI, ang2+rotation+PI, OPEN);
    rotation++;
  }

  icolour=color(225, 3, 62, 240);
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
  fill(255, 224, 67, 200);
  noSmooth();
  text(sentence, i, j);

  sentence="INDEPENDENCE\nDAY\n\n";
  font2=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  textFont(font2, 100);
  textAlign(CENTER, BOTTOM );
  fill(255);
  noSmooth();
  //text(sentence, width/2, height);


  save("diagonal5.jpeg");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

