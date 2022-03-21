float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
PImage  img;

void setup() 
{
  int llll=12;
  // img = loadImage("c ("+llll+").jpg");
  int ll=2;

  //size( 8192, 5120);
  //size( 1920, 1080);
  size( 7680, 4320);
  background(0);
  //  quadrants();// design of background 
  // arter();
  //  popup();
  //cor(.9,.9, min(width, height)/50, (20));
  noSmooth();
  ab(1.05, .05, min(height, width)/5*1.25, -70, .1);
  xx(.5, .5, color(255, 50), color(0, 50), (min(height, width)/5), 90, .1);
  save("diagonalck ("+llll+").png");
  // save("diagonalc ("+llll+").tiff");
  //save("diagonalck ("+llll+").jpg");
}

float i, j, //font size 
n= 30, //length of plus 
m=n/3, 
t=n*.5;
color  c1= color(0, 143, 229), //background upper gradient 
c2= color(255, 255, 0, 200), //background lower gradient 
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
    color icolour1=color(0, 255, 180, 10);
    color icolour2=color(20);
    float  v1=.5, v2=.5, v3=.5, v4=1;
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


void arter() {

  float i, j, //font size 
  n= 280, //length of plus 
  m=n/3;
  {
    float v1=.5, v2=.5, v3=1.5, v4=1.5;

    noSmooth();
    {
      {

        for (j=height*v2-3*m; j >height*v2-height*v4/2; j-=3*m) {
          for (i=width*v1+3*n; i <width*v3/2+width*v1; i+=3*n) {
            aarter_compoents(i, j, n, m);
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
            aarter_compoents(i, j, n, m);
          }
        }
      }

      {

        for (j=height*v2+3*m; j <height*v2+height*v4/2; j+=3*m) {
          for (i=width*v1-3*n; i >width*v1-width*v3/2; i-=3*n) {
            aarter_compoents(i, j, n, m);
          }
        }
      }

      {

        for (j=height*v2; j <height*v2+height*v4/2; j+=3*m) {
          for (i=width*v1; i <width*v3/2+width*v1; i+=3*n) {
            aarter_compoents(i, j, n, m);
          }
        }
      }
    }
  }
}

void aarter_compoents(float i, float  j, float n, float m)
{
  art(i, j, n, m);
}
void art(float i, float  j, float n, float m)
{ 
  noStroke();
  noSmooth();
  {
    /*if (i==width/2&&j== height/2) 
     {
     String s = "Albert Einstein";
     m=min(width, height)/40;
     fill(220, 200);
     rect( i-m*s.length()/2/2, j-2*m/2, m*s.length()/2, 2* m, min(width, height)/200);
     textFont(font, m);
     font=loadFont("MicrosoftJhengHeiUIBold-255.vlw"); 
     fill(0);
     text(s, i-m*s.length()/2, j-2*m/2, m*s.length(), 2* m);
     }else */


    {  

      {  
        color icolour1=color(0);
        color icolour2=color(255);
        float v1=.5, v2=0, v3=.5, v4=1;
        // line(v1*width, v2*height, v3*width, v4*height);
        float v5=dist(v1*width, v2*height, v3*width, v4*height);
        {

          float v6=dist(i, j, v3*width, v4*height);
          //    float x = lerp(v1*width, v3*width, i/v5) ;
          //float y = lerp(v2*height, v4*height, j/v5);
          fill(lerpColor(icolour1, icolour2, map( v6, 0, v5, 0, 1)));
        }
      }

      String lines[] = loadStrings("list2.txt");
      font=loadFont("MicrosoftJhengHeiLight-255.vlw");
      textFont(font, min(width, height)/150);
      strokeWeight(min(width, height)/100);
      textAlign(CENTER, CENTER);
      int index = int(random(lines.length));
      text(lines[index], i-n, j-n/2, 2*n, n);
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
void popup() {
  float n1=.5, n2=.5;
  String s = "17:04";
  m=min(width, height)/50;
  fill(220, 200);
  // rect( width*n1-m*s.length()/2/2, height*n2-2*m/2, m*s.length()/2, 2* m, min(width, height)/200);
  textAlign(CENTER, CENTER);
  font=loadFont("CenturyGothic-Bold-255.vlw"); 
  textFont(font, m);
  fill(50);
  smooth();
  text(s, width*n1-m*s.length()/2, height*n2-2*m/2, m*s.length(), 2* m);
}
void cor(float i, float j, float k, color c)
{ 
  fill(c);
  noStroke();
  ellipse(width*i, height*j, k, k);
}
void ab(float n1, float n2, float dia, float n0, float diff)  
{


  icolour1=color(255, 0, 0, 100);
  icolour2=color(0, 0, 255, 100);
  int cmin=100, cmax=255, alp=200;
  fill(255);      
  noStroke();

  //ellipse( width*n1, height*n2, 8*dia, 8*dia);

  for (float n=0; n<360; n=n+diff)
  {
    noStroke();
    //  fill(icolour1);
    {

      float no= n*(cmax-cmin)*6/360;

      int k=floor(no/(cmax-cmin));
      int ll=0;
      if (k%2==0)
      {
        ll=1;
      } 
      if (k%2==1)
      {
        ll=-1;
      }
      float p=abs(no-k*(cmax-cmin));
      float b1=0, b2=0, b3=0;

      if (k==0)
      {
        b1=cmin;
        b2=cmin+ll*p;
        b3=cmax;
      }
      if (k==1)
      {
        b1=cmin;
        b2=cmax;
        b3=cmax+ll*p;
      }
      if (k==2)
      {
        b1=cmin+ll*p;
        b2=cmax;
        b3=cmin;
      }
      if (k==3)
      {
        b1=cmax;
        b2=cmax+ll*p;
        b3=cmin;
      }
      if (k==4)
      {
        b1=cmax;
        b2=cmin;
        b3=cmin+ll*p;
      }  
      if (k==5)
      {
        b1=cmax+ll*p;
        b2=cmin;
        b3=cmax;
      }
      fill(b1, b2, b3, alp);
    }
    // fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));

    arc( width*n1, height*n2, 8*dia, 8*dia, radians(n+n0), radians(n+diff+n0), PIE);
    //  ellipse( width*n1, height*n2, dia, dia);
  }
}
void xx(float n1, float n2, color icolour1, color icolour2, float dia, float n0, float diff)
{   

  color icolour3=color(255, 40);

  color icolour4=color(0, 40);
  int cmin=0, cmax=255, alp=255;
  for (float n=180; n>0; n=n-1)
  {
    noStroke();

    fill(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
    arc( width*n1, height*n2, dia, dia, -radians(n-n0)+PI/4, +radians(n+n0)+PI/4, OPEN);
    arc( width*n1, height*n2, dia, dia, -radians(n-n0)+PI/4*2, +radians(n+n0)+PI/4*2, OPEN);
  }
  for (float n=0; n<360; n=n+diff)
  {
    noStroke();


    fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
    arc( width*n1, height*n2, dia, dia, radians(n+n0), radians(n+diff+n0), PIE);
    //  ellipse( width*n1, height*n2, dia, dia);
  }
}

