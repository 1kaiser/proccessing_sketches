float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang;
//PFont //font, //font1, //font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
//PImage  //img;

void setup() 
{
  int llll=7;
  // //img = loadImage("c ("+llll+").jpg");
  int ll=2;

  //size( 7860/3, 4320/3);//size( 8192/3, 5120/3);
  //size( 7860/3, 4320/3);//size( 1920/3, 1080/3);
  size( 7860/3, 4320/3);//size( 7680/3, 4320/3);
  //background(255);
  quadrants();// design of //background 

  save("diagonalck ("+llll+").png");
  // save("diagonalc ("+llll+").tiff");
  //save("diagonalck ("+llll+").jpg");
}

float i, j, spacer=10, fs=900, ////font size( 7860/3, 4320/3);//size 
n= 30, //length of plus 
m=n/3, 
t=n*.5;
color  c1= color(0, 143, 229), ////background upper gradient 
c2= color(255, 255, 0, 200), ////background lower gradient 
c3= color(144, 79, 144), //dot colour 
c5= color(49, 164, 255, 200), //text colour 
c6= color(0, 255, 130, 20);
void quadrants()
{
  float v1=.5, v2=.5, v3=1.5, v4=1.5;

  noSmooth();
  {
    {

      for (j=height*v2-3*m; j >height*v2-height*v4/2; j-=3*m) {
        for (i=width*v1+3*n; i <width*v3/2+width*v1; i+=3*n) {
          quadrant_compoents();
        }
      }
    }

    {

      for (j=height*v2; j >height*v2-height*v4/2; j-=3*m) {
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

      for (j=height*v2+3*m; j <height*v2+height*v4/2; j+=3*m) {
        for (i=width*v1-3*n; i >width*v1-width*v3/2; i-=3*n) {
          quadrant_compoents();
        }
      }
    }

    {

      for (j=height*v2; j <height*v2+height*v4/2; j+=3*m) {
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
  //  dots();
  //art();
}
void art()
{
  {

    String s = "kaiser";
    //font=loadFont("MicrosoftJhengHeiLight-255.vlw");
    //textFont(//font, 12);
    stroke(255); 
    strokeWeight(min(width, height)/100);
    noSmooth(); 
    textAlign(CENTER, CENTER);
    text(s, i-n, j-n/2, 2*n, n);
    if (i==width/2&&j== height/2)
    {
      s = "KAISER ROY";
      fill(255);
      rect( i-n, j-n/2, 2*n, n, min(width, height)/500);
      //textFont(//font, 20);
      //font=loadFont("MicrosoftJhengHeiUIBold-255.vlw"); 
      fill(0);
      text(s, i-n, j-n/2, 2*n, n);
    }



    // rectMode(CORNER);
    /*  
     float m=min(width, height)/80;
     fill(230);
     noStroke();
     rect( i-m*s.length()/2/2, j-2*m/2, m*s.length()/2, 2* m );
     
     //  fill(0);
     strokeWeight(min(width, height)/100);
     */
  }
}

void dots()
{ 

  noSmooth();

  noFill();
  {  
    color icolour1=color(255, 0, 180, 100);
    color icolour2=color(255, 230, 0, 100);
    float v1=0, v2=0, v3=1, v4=1;
    // line(v1*width, v2*height, v3*width, v4*height);
    noSmooth();

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



void plus_cross()
{ 
  smooth();  
  {  
    color icolour1=color(0, 255, 180, 20);
    color icolour2=color(255, 20);
    float v1=.5, v2=0, v3=.5, v4=1;
    // line(v1*width, v2*height, v3*width, v4*height);
    noSmooth();

    float v5=dist(v1*width, v2*height, v3*width, v4*height);
    {

      float v6=dist(i, j, v3*width, v4*height);
      //    float x = lerp(v1*width, v3*width, i/v5) ;
      //float y = lerp(v2*height, v4*height, j/v5);
      stroke(lerpColor(icolour1, icolour2, map( v6, 0, v5, 0, 1)));
    }
  }//stroke(c6);
  strokeWeight(t);  
  point(i, j );
  line(i-n, j-n, i+n, j+n);// up to down  
  line(i-n, j+n, i+n, j-n);// down to up
}

