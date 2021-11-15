float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
PImage  img;

void setup() 
{
  int llll=444;
  //img = loadImage("c ("+llll+").jpg");
  //  int ll=2;

  // size( 1920, 1080);
  // size( 5760, 3240);
  size( 7680, 4320);
  background(240);
  // quadrants();// design of background 
  //xx();
  { 
    noStroke();
    fill(250);
    rectMode(CENTER);  // Set rectMode to CENTER
    rect(width*.5, height*.5, height*.2, width*.2, min(width, height)/50);
  }  
  saber(.45, .47, .45, .52, min(width, height)/180, color(255, 30, 30, 60));

  /*  filter(BLUR, 10);
   save("diagonalck ("+llll+").tiff");
   img = loadImage("diagonalck ("+llll+").tiff");
   size( 7680, 4320);
   */
  int uu= min(width, height)/50;
  img = loadImage("diagonalck ("+llll+").jpg");   
  imageMode(CENTER);
  image(img, 0, 0, height*.2, width*.2, uu, uu, uu, uu);
  saber(.45, .47, .45, .52, min(width, height)/200, color(255, 50, 50));

  //  saber(.45, .47, .45, .52, min(width, height)/300, color(255, 40));
  save("diagonalck ("+llll+").png");
  //  save("diagonalc ("+llll+").tiff");
  //save("diagonalck ("+llll+").jpg");
}
float i, j, spacer=10, fs=900, //font size 
n=10, //length of plus 
t=n*.5;
color  c1= color(0, 143, 229), //background upper gradient 
c2= color(255, 255, 0, 200), //background lower gradient 
c3= color(144, 79, 144), //dot colour 
c5= color(49, 164, 255, 200), //text colour 
c6= color(255, 50, 50);
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
  //plus_cross();
  dots();
}
void dots()
{ 
  noFill();
  {  
    color icolour1=color(255, 100);
    color icolour2=color(0);
    float v1=0, v2=0, v3=1, v4=1;
    // line(v1*width, v2*height, v3*width, v4*height);
    float v5=dist(v1*width, v2*height, v3*width, v4*height);
    {

      float v6=dist(i, j, v3*width, v4*height);
      //    float x = lerp(v1*width, v3*width, i/v5) ;
      //float y = lerp(v2*height, v4*height, j/v5);
      stroke(lerpColor(icolour1, icolour2, map( v6, 0, v5, 0, 1)));
    }
  }
  // stroke(c6);
  // strokeWeight(t/3*2);
  //  quad(i-n, j-n, i+n, j-n, i+n, j+n, i-n, j+n);// up to down  
  // line(i-n, j+n, i+n, j-n);// down to up
  strokeWeight(t*1.5); 
  point(i, j );
  //strokeWeight(t*1.5/2);
  strokeWeight(1);
  ellipse(i, j, 8*t, 8*t);
  ellipse(i, j, 2*8*t, 2*8*t);

  ellipse(i, j, 2* 2*8*t, 2*2*8*t);

  ellipse(i, j, 2*2* 2*8*t, 2* 2*2*8*t);
}

void saber(float n1, float n2, float n3, float n4, float n5, color c6)
{ 
  noSmooth();
  stroke(c6);
  strokeWeight(n5); 
  strokeCap(ROUND);
  line(n1*width, n2*height, n3*width, n4*height);
  //line(i-n, j-n, i+n, j+n);// up to down  
  //  line(i-n, j+n, i+n, j-n);// down to up
}
void plus_cross()
{ 
  stroke(c6);
  strokeWeight(t); 
  line(i-n, j-n, i+n, j+n);// up to down  
  line(i-n, j+n, i+n, j-n);// down to up
}
void xx()
{   
  float n1, n2;
  n1=1;
  n2=1.2;

  icolour1=color(0, 255, 255, 40);
  icolour2=color(0, 255, 0, 40);
  color icolour3=color(255, 40);

  color icolour4=color(0, 40);
  int cmin=0, cmax=255, alp=255;
  float dia=min(height, width)/5*5;
  float diff=.1;
  for (float n=180; n>0; n=n-1)
  {
    noStroke();

    fill(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
    arc( width*n1, height*n2, dia, dia, -radians(n)+PI/4, +radians(n)+PI/4, OPEN);
    arc( width*n1, height*n2, dia, dia, -radians(n)+PI/4*2, +radians(n)+PI/4*2, OPEN);
  }
  for (float n=0; n<360; n=n+diff)
  {
    noStroke();


    fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
    arc( width*n1, height*n2, dia, dia, radians(n), radians(n+diff), PIE);
    //  ellipse( width*n1, height*n2, dia, dia);
  }
}

