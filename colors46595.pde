float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
PImage  img;

void setup() 
{
  int llll=14;
  img = loadImage("c ("+llll+").jpg");
  //  int ll=2;
  smooth();
  // size( 1920, 1080);
  // size( 5760, 3240);
  size( 7680, 4320);
  //  size( img.width, img.height);

  if (img.width/img.height<=1)
  {
    float rat=img.width*height/img.width;
    image(img, 0, -rat/2+height/2, width, rat/2+height/2);
  } 
  if (img.width/img.height>1) 
  {
    float rat=img.height*width/img.height;
    image(img, -rat/2+width/2, 0, rat/2+width/2, height);
  }
  image(img, 0, 0, width, height);

  //filter(GRAY);
  //background(255, 220, 0, 50);

  filter(POSTERIZE, 13);
  quadrants();// design of background//
  filter(POSTERIZE, 2);

  {   
    float n1=0, n2=.9, n3=1, n4=.2;

    noStroke();
    fill(250);
    rect(n1*width, n2*height, width*n3, height*n4);
  }

  {
    noSmooth();
    String s = "“ Shobi amar shopno aar shukher chobi.. kolpona ”";
    fill(50);
    float n1=.5, n2=.95;
    font=loadFont("MicrosoftJhengHeiUIBold-255.vlw");

    float m=min(width, height)/50;
    textFont(font, m);
    stroke(20); 
    fill(20);
    strokeWeight(min(width, height)/200);

    textAlign(CENTER, CENTER);
    text(s, n1*width, n2*height);
  }


  save("diagonalck ("+llll+").png");
  // save("diagonalc ("+llll+").tiff");
  //save("diagonalck ("+llll+").jpg");
}
float i, j, spacer=min(width, height)*.1, fs=900, //font size 
n=2, //length of plus 
t=n*.5;
color  c1= color(0, 143, 229), //background upper gradient 
c2= color(255, 255, 0, 200), //background lower gradient 
c3= color(144, 79, 144), //dot colour 
c5= color(49, 164, 255, 200), //text colour 
c6= color(255, 50, 50, 100);
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

