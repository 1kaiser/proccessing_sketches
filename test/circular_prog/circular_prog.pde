int i, j;
//PFont //font;
float an1=0, an2=15, h=45, ang1=radians(an1), ang2=radians(an2);
String sentence;//text in the centre
color icolour, icolour1, icolour2;
/*flag colour 255,153,51  0, 0, 128   19, 136, 8*/
void setup() 
{
  //background(0, 0, 0, 150);
  //size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  size( 7860/3, 4320/3);//size(  8192, 5120 );
  c_centre();
  icolour1=color(255, 255, 0, 20);
  icolour2=color(255, 0, 0, 20);

  float rotation=radians(h);
  for (float n=dist (0, 0, i, j)*1.5; n>0; n=n-250)
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
    each_ellipse1( n, ang1, rotation );


    //ellipse(i+n*cos(ang1+rotation), j+n*sin(ang1+rotation), 2*dist (i, j, i+n*cos(ang1+rotation), j+n*sin(ang1+rotation)), 2*dist (i, j, i+n*cos(ang1+rotation), j+n*sin(ang1+rotation)));
    //ellipse(i+n*cos(ang1+rotation+PI/2), j+n*sin(ang1+rotation+PI/2), 2*dist (i, j, i+n*cos(ang1+rotation+PI/2), j+n*sin(ang1+rotation+PI/2)), 2*dist (i, j, i+n*cos(ang1+rotation+PI/2), j+n*sin(ang1+rotation+PI/2)));
    //ellipse(i+n*cos(ang1+rotation+PI), j+n*sin(ang1+rotation+PI), 2*dist (i, j, i+n*cos(ang1+rotation+PI), j+n*sin(ang1+rotation+PI)), 2*dist (i, j, i+n*cos(ang1+rotation+PI), j+n*sin(ang1+rotation+PI)));
    //ellipse(i+n*cos(ang1+rotation+PI*3/2), j+n*sin(ang1+rotation+PI*3/2), 2*dist (i, j, i+n*cos(ang1+rotation+PI*3/2), j+n*sin(ang1+rotation+PI*3/2)), 2*dist (i, j, i+n*cos(ang1+rotation+PI*3/2), j+n*sin(ang1+rotation+PI*3/2)));
    rotation++;
  }

  char[] letters = { 
    // 'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y', 
    5, 2, 4, 7, 3, 7, 7, 6, 9
  };

  int no=0; 

  float i=width*.90;
  float j=height-width*.10;
  float y2=dist(width*.80, j-width*.10, width, height);
  float y0=2*y2/15;
  for (float y1=-y0; y1<=y0; y1+=y0)
  {

    for (float x1=-y0; x1<=y0; x1+=y0)

    { 

      stroke(35, 35, 35);
      noSmooth();
      strokeWeight(50);

      fill(color(0, 0, 0, 200));
      noSmooth();
      // ellipse(width/2, height/2, 2*sqrt(2)*250*sqrt (2), 2*sqrt(2)*250*sqrt (2));//central circle
      stroke(color(0, 0, 0, 200));
      // strokeWeight(1);
      // noFill();
      noStroke();
      fill(color(0, 0, 0, 150));
      noSmooth();
      //noSmooth();
      /*      for (float n=0; n<dist (0, 0, width, height)/20; n++)
       {
       ellipse(i+x1, j+y1, 2*n, 2*n);//central circle
       }
       */      ellipse(i+x1, j+y1, 2*y2/20, 2*y2/20);
      /*    stroke(255);
       
       strokeWeight(y2/225);
       noFill();
       
       // ellipse(i, j, 2*sqrt(2)*250*sqrt (2), 2*sqrt(2)*250*sqrt (2));
       ellipse(i+x1, j+y1, (2/20-sqrt (2)/225)*y2, (2/20-sqrt (2)/225)*y2);
       
       */
      sentence=""+int(letters[no])+"";
      no++;
      //font=loadFont("AgencyFB-Bold-255.vlw");
      //textFont(//font, y2/13);
      textAlign(CENTER, CENTER);
      fill(255, 255, 255);
      noSmooth();

      text(sentence, i+x1, j+y1);
    }
  }


  sentence="BETTER\n\n";
  //font=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
  //textFont(//font, dist(0, 0, width, height)/90);
  textAlign(CENTER, BOTTOM );
  fill(255);
  noSmooth();
  text(sentence, width/2, height);

  save("diagonal27.tif");
}
void each_ellipse1(float n, float ang1, float rotation )
{
  for (float tang=0; tang<6; tang++)
  { 
    ellipse(i+n*cos(ang1+rotation+PI*tang/3), j+n*sin(ang1+rotation+PI*tang/3), 2*dist (i, j, i+n*cos(ang1+rotation+PI*tang/3), j+n*sin(ang1+rotation+PI*tang/3)), 2*dist (i, j, i+n*cos(ang1+rotation+PI*tang/3), j+n*sin(ang1+rotation+PI*tang/3)));
  }
}


void c_centre()// canvas centre 2089ff
{
  i=width/2;
  j=height/2;
}

