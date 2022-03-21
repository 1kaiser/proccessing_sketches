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
  //size( 8192, 5120);
  size(7680, 4320);
  background(255); 
  //fill(255);  

  {
    noFill();
    strokeWeight(2);
    for (float w=width/4; w<width; w++) {
      for  (float v=0; v<height; v++) {
        // stroke(255); 
        stroke(lerpColor(color(0, random(10, 20)), color(0, random(150, 180)), map(dist(0, 0, w, v), 0, dist(0, 0, width, height), 0, 1)));
        point(w, v);
      }
    }
  }
  {
    strokeWeight(max( min(width, height)/120, 10));
    float i, j, xx=.5, yy=.5, zx=height/10, zy=height/10, ny, nx, n=max( min(width, height)/50, 2);
    ny=n;
    nx=n;
    for ( j=height*yy- zy; j <height*yy+zy; j+=ny) {
      for ( i=width*xx- zx; i <width*xx+zx; i+=nx) { 
        //stroke(sen(i, j, xx-zx/width/2, yy-zy/height/2, xx+zx/width/2, yy+zy/height/2)); 
        stroke(sen(i, j, xx-zx/width/1.5, yy-zy/height/1.5, xx, yy));  
        point(i, j);
      }
    }
  }
  noStroke();


  // quadrants();// design of background 
  //xx();





  { 
    char[] letters = { 
      //  'K', 'A', 'I', 'S', 'E', 'R', 'R', 'O', 'Y',  // 5, 2, 4, 7, 3, 7, 7, 6, 9 //'K', '2', '4', '7', 'E', '7', '7', '6', 'Y', // 'K', '2', 'I', '7', '3', '7', 'R', '6', '9',
      ' ', ' ', ' ', 'd', ' ', ' ', ' ', 'd', ' ',
    };
    {
      int no=0; 
      noStroke();

      float y2=min(width, height)/5*sqrt(2); 
      float y0=2*y2/15/2; 
      float i=width-2.5*y0; 
      float j=height-2.5*y0; 
      for (float y1=-y0; y1<=y0; y1+=y0)
      {

        for (float x1=-y0; x1<=y0; x1+=y0)

        {  

          sentence=""+letters[no]+""; 

          if (letters[no] !='d') {
            fill(color(255)); 
            smooth(); 
            ellipse(i+x1, j+y1, 2*y2/20/3, 2*y2/20/3); 

            font=loadFont("AgencyFB-Bold-255.vlw"); 
            textFont(font, y2/13); 
            textAlign(CENTER, CENTER); 
            fill(255, 255, 255); 
            smooth(); 

            //text(sentence, i+x1, j+y1);}
          }  
          no++;
        }
      }
    }

    save("diagonalck ("+llll+").png");
    //  save("diagonalc ("+llll+").tiff");
    //save("diagonalck ("+llll+").jpg");
  }
}
color sen(float i, float  j, float v1, float v2, float v3, float v4) {   
  color icolour1=color(255, 0, 0);
  color icolour2=color( 255, 255, 0);
  // line(v1*width, v2*height, v3*width, v4*height);
  float v5=dist(v1*width, v2*height, v3*width, v4*height);
  {  
    float v6=dist(i, j, v3*width, v4*height);
    //    float x = lerp(v1*width, v3*width, i/v5) ;
    //float y = lerp(v2*height, v4*height, j/v5);
    return color(lerpColor(icolour1, icolour2, map( v6, 0, v5, 0, 1)));
  }
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

