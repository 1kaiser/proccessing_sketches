float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
//PImage  //img;

void setup() 
{
  int llll=1;
  //img = loadImage("c ("+llll+").jpg");

  smooth();
  // size( 7860/3, 4320/3);//size( 1920/3, 1080/3);
  // size( 7860/3, 4320/3);//size( 5760/3, 3240/3);
  //size( 7860/3, 4320/3);//size( 7680/3, 4320/3);
  int ll=7;
  size( 7860/3, 4320/3);//size(ll*7860, 4320);

  for ( ll=0; ll<=7; ll++)
  {
    //image(//img, (ll)*7860, 0, 7860, 4320);
    noStroke();  
    // fill(color(random(180, 255), random(180, 255), random(180, 255), random(180, 255)));
    fill(color(random(50, 240), random(50, 240), random(50, 240), random(50, 240)));
    triangle((ll)*7860, 4320*.7, (ll)*7860, 4320, (ll-1)*7860+4320*.7, 4320);
    stroke(20, 200);
    strokeWeight(100);
    point((ll-1)*7860+4320*.91, 4320*.91);
  }

  // quadrants();// design of //background//


  //  tex(s);
  llll=8;
  save("diagonalck ("+llll+").png");

  // save("diagonalck ("+llll+").png");
  // save("diagonalc ("+llll+").tiff");
  //save("diagonalck ("+llll+").jpg");
}


float i, j, spacer=min(width, height)*.1, fs=900, ////font size( 7860/3, 4320/3);//size 
n=2, //length of plus 
t=n*.5;
color  c1= color(0, 143, 229), ////background upper gradient 
c2= color(255, 255, 0, 200), ////background lower gradient 
c3= color(144, 79, 144), //dot colour 
c5= color(49, 164, 255, 200), //text colour 
c6= color(0);
void quadrants()
{
  float v1=.5, v2=.5, v3=1.2, v4=1.2;


  {
    {

      for (j=height*v2-3*n; j >height*v2-height*v4/2; j-=3*n) {
        for (i=width*v1+3*n; i <width*v3/2+width*v1; i+=3*n) {
          quadrant_compoents();
        }
      }
    }

    {

      for (j=height*v2; j >height*v2-height*v4/2; j-=3*n) {
        for (i=width*v1; i >width*v1-width*v3/2; i-=3*n) {
          if (j==height*v2&&i==width*v1)
          {
            i-=3*n;
          }
          quadrant_compoents();
        }
      }
    }

    {

      for (j=height*v2+3*n; j <height*v2+height*v4/2; j+=3*n) {
        for (i=width*v1-3*n; i >width*v1-width*v3/2; i-=3*n) {
          quadrant_compoents();
        }
      }
    }

    {

      for (j=height*v2; j <height*v2+height*v4/2; j+=3*n) {
        for (i=width*v1; i <width*v3/2+width*v1; i+=3*n) {
          quadrant_compoents();
        }
      }
    }
  }
}

void quadrant_compoents()
{
  plus_cross();
  // dots();
}


void dots()
{ 



  strokeWeight(t*1.5); 
  point(i, j );
}


void plus_cross()
{ 
  stroke(c6);

  strokeWeight(t); 
  line(i-n, j-n, i+n, j+n);// up to down  
  line(i-n, j+n, i+n, j-n);// down to up
}
void tex(String s)
{
  noSmooth();
  // String s = "“ Shobi amar shopno aar shukher chobi.. kolpona ”";
  fill(50);
  float n1=.5, n2=.9;
  //font=loadFont("MicrosoftJhengHeiUIBold-255.vlw");

  float m=min(width, height)/50;
  //textFont(//font, m);
  stroke(20); 
  fill(20);
  strokeWeight(min(width, height)/200);

  textAlign(CENTER, CENTER);
  text(s, n1*width, n2*height);
}

