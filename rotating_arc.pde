int i, j, n;

float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
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


  icolour1=color(19, 136, 8, 200);
  icolour2=color(255, 153, 51, 200);
  for (n=0; n<5*250*sqrt (2); n=n+150)
  {
    noStroke();
    fill(lerpColor(icolour1, icolour2, map(n, 0, 5*250*sqrt (2), 0, 1)));
    strokeWeight(50);
    noSmooth();
    arc(i, j, 2*n, 2*n, ang1+rotation, ang2+rotation, OPEN);
    rotation++;
  }


  icolour=color(0, 0, 128, 200);
  for (n=0; n<250*sqrt (2); n++)
  {

    stroke(icolour);
    strokeWeight(1);
    noFill();
    noSmooth();
    ellipse(i, j, 2*sqrt(2)*n, 2*sqrt(2)*n);//central circle
  }

  sentence="68";
  font1=loadFont("AgencyFB-Bold-255.vlw");
  textFont(font1, 250*sqrt (2)*2);
  textAlign(CENTER, CENTER);
  fill(255, 224, 67, 240);
  noSmooth();
  text(sentence, i, j);

  sentence="INDEPENDENCE\nDAY\n\n";
  font2=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  textFont(font2, 100);
  textAlign(CENTER, BOTTOM );
  fill(255);
  noSmooth();
  text(sentence, width/2, height);


  save("diagonal3.tif");
}

void c_centre()// canvas centre 
{
  i=width/2;
  j=height/2;
}

