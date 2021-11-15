float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;
PImage  img;

void setup() 
{
  int llll=13;
  // img = loadImage("c ("+llll+").jpg");
  //  int ll=2;

  //size( 1920, 1080);
  // size( 5760, 3240);
  size( 7680, 4320);
  //size( img.width, img.height);
  /*

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
   // size( img.width*ll, img.height*ll);
   //image(img, -img.width/2, 0, img.width/2, height);
   // filter(GRAY);
   // filter(POSTERIZE, 100);
   */  background(255);
  //  quadrants();// design of background 
  {
    float n1, n2;
    n1=1;
    n2=-0.1;

    icolour1=color(255, 0, 0, 100);
    icolour2=color(0, 0, 255, 100);
    int cmin=100, cmax=255, alp=200;
    float dia=4*dist(0, 0, height, width);
    float diff=.01;
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

      arc( width*n1, height*n2, 8*dia, 8*dia, radians(n), radians(n+diff), PIE);
      //  ellipse( width*n1, height*n2, dia, dia);
    }
  }
  /*  {    
   { 
   float n1=.5;
   float n2=.5;
   
   icolour1=color(130, 0, 255, 40);
   icolour2=color(0, 130, 255, 40);
   float dia=min(height, width)/5*1.2/3*2;
   for (float n0=360-0; n0>0; n0=n0-15) {
   float s1=random(width*.05, width*.8);
   float a1=s1*cos(radians(n0));
   float a2=s1*sin(radians(n0));
   float dia1=lerp(dia*.08, dia*.5, map(s1, width*.05, width*.8, 0, 1));
   float gap=radians(60);
   for (float n=180-0; n>0; n=n-30)
   {
   noStroke();
   
   fill(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
   arc( width*n1+a1, height*n2+a2, dia1, dia1, -radians(n)-gap/2+radians(n0), +radians(n)-gap/2+radians(n0), OPEN);
   arc( width*n1+a1, height*n2+a2, dia1, dia1, -radians(n)+gap/2+radians(n0), +radians(n)+gap/2+radians(n0), OPEN);
   }
   }
   }
   }*/
  // filter(BLUR, 5);
  /*      icolour1=color(255, 0, 255, 40);  icolour2=color(0, 0, 255, 40);
   {
   noSmooth();
   String s = "A quick brown fox jumps over the lazy dog";
   fill(50);
   float n1=.6, n2=.4;
   
   font=loadFont("MicrosoftJhengHeiLight-255.vlw");
   
   //   font=loadFont("MicrosoftJhengHeiUIBold-255.vlw");
   textFont(font, min(width, height)/40);
   color icolour1=color(255);
   color icolour2=color(255);
   float m=.1*min(width, height);
   rectMode(RADIUS);  
                                              /*  ellipseMode(CENTER); 
   fill(0, 130, 255);
   noStroke();
   ellipse(n1*width, n2*height, 2.5*m, 2.5*m);
   */


  //filter(BLUR, 2);
  /*
    {
   n1=.46; 
   n2=.61;
   icolour1=color(255, 255, 0, 40);
   icolour2=color(255, 0, 0, 40);     
   float dia=min(height, width)/5*1.2/3;
   float gap=radians(60);
   for (float n=180-0; n>0; n=n-20)
   {
   noStroke();
   
   fill(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
   arc( width*n1, height*n2, dia, dia, -radians(n)+gap, +radians(n)+gap, OPEN);
   arc( width*n1, height*n2, dia, dia, -radians(n)+gap*2, +radians(n)+gap*2, OPEN);
   }
   }
   */  //   
  /*    n1=.5; 
   n2=.5;
   icolour1=color(0, 255, 255, 40);
   icolour2=color(0, 255, 130, 40);
   float dia=min(height, width)/5*1.2;
   float gap=radians(60);
   for (float n=180-0; n>0; n=n-1)
   {
   noStroke();
   
   fill(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
   arc( width*n1, height*n2, dia, dia, -radians(n)+gap, +radians(n)+gap, OPEN);
   arc( width*n1, height*n2, dia, dia, -radians(n)+gap*2, +radians(n)+gap*2, OPEN);
   }        
   float diff=.1;
   for (float n=0; n<360; n=n+diff)
   {
   noStroke();
   fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
   arc( width*n1, height*n2, dia, dia, radians(n), radians(n+diff), PIE);
   }
   noStroke();
   fill(250, 100);
   // ellipse(width*n1, height*n2, dia, dia);
   
   fill(10, 100);
   strokeWeight(min(width, height)/100);
   //   filter(BLUR, 5);
   textAlign(CENTER, CENTER);
   text(s, n1*width, n2*height, m, m);
   } 
   */
  /*  {
   float y11=min(width, height)/8;
   float n1=.55, n2=.5;
   float s1=y11;
   //  noFill();
   //  stroke(0, 255, 180, 180);
   fill(255);
   stroke(255);
   strokeWeight(min(width, height)/80); 
   strokeJoin(MITER);
   smooth();
   beginShape();
   for (float n=60; n<360; n=n+120)
   {
   float a1=n1*width+s1*cos(3*PI/2+radians(n));
   float a2=n2*height+s1*sin(3*PI/2+radians(n));
   
   vertex(a1, a2);///
   }
   endShape(CLOSE);
   noFill();
   {    
   for (float i=2; i<10; i++) 
   {
   s1=s1+1*min(width, height)/80/i;
   stroke(255, 250/i);
   strokeJoin(MITER);
   strokeWeight(min(width, height)/80/i); 
   beginShape();
   for (float n=60; n<360; n=n+120)
   {
   float a1=n1*width+s1*cos(3*PI/2+radians(n));
   float a2=n2*height+s1*sin(3*PI/2+radians(n));
   
   vertex(a1, a2);///
   }
   endShape(CLOSE);
   }
   }
   }
   */
  /*  {  
   
   
   float n1=.5, n2=.5;
   
   color icolour1=color(255);
   color icolour2=color(255);
   float m=.1*min(width, height);
  /* {
   stroke(10); 
   fill(230);
   strokeWeight(min(width, height)*.001);
   rect(n1*width-m*2, n2*height-m*2, 4*m, 4*m, 2* m);
   }* /
   float ang=radians(0);
   strokeWeight(10);
   strokeCap(ROUND);
   noSmooth();
   noFill();
   for (float n=180-60; n>=0+60; n=n-5)
   {
   stroke(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
   line(n1*width+m*cos( -radians(n)+ang), n2*height+m*sin( -radians(n)+ang), n1*width+m*cos( +radians(n)+ang), n2*height+m*sin( +radians(n)+ang));
   // rotation++;
   }
   }
   */

  /*
  {
   smooth();
   
   
   float y0=min(width, height)/30;
   {
   float n1=.5, n2=.5, n3=.09, n4=.03;
   stroke(60, 50, 50, 80); 
   noFill();
   strokeWeight(min(width, height)/120);
   rect(n1*width-width*n3, n2*height-height*n4, 2*width*n3, 2*height*n4, min(n3*width, n4*height)/4);
   strokeWeight(min(width, height)/200);
   rect(n1*width-width*n3, n2*height-height*n4, 2*width*n3, 2*height*n4, min(n3*width, n4*height)/4);
   
   noStroke();
   fill(100);
   rect(n1*width-width*n3, n2*height-height*n4, 2*width*n3, 2*height*n4, min(n3*width, n4*height)/4);
   }
   String sentence="VISIONARY";
   int no=0;
   float n1=.5, n2=.5;
   noSmooth();
   for (float y1=0; y1<1; y1+=1)
   {
   
   for (float x1=-4; x1<5; x1+=1)
   
   { 
   font=loadFont("MicrosoftJhengHeiLight-255.vlw");
   textFont(font, min(width, height)/30);
   textAlign(CENTER, CENTER);
   fill(255);
   text(sentence.charAt(no), n1*width+x1*y0, n2*height+y1*y0);
   no++;
   }
   }
   }
   */
  //  {   
  //    float n1=0, n2=.9, n3=1, n4=.2;

  //    noStroke();
  //    fill(0);
  //    rect(n1*width, n2*height, width*n3, height*n4);
  //  }
  /*  {
   noSmooth();
   float n1=0, n2=.9, n3=1, n4=min(width, height)/1000;
   strokeWeight(1); 
   strokeCap(SQUARE);
   for (float i=n1*width; i<=n3*width; i++) 
   {
   stroke(255, map(i, n1*width, n3*width, 1, 255));
   line(n3*width-i, n2*height+n4-.5, n3*width-i, n2*height-n4+.5);
   }
   }
   */  /*{
   float n1=.25/3, n2=.9;
   sentence="DEVOTE";
   font2=loadFont("Aharoni-Bold-255.vlw");
   textFont(font2, min(width, height)/35);
   textAlign(CENTER, CENTER );
   fill(255, 200, 0);
   noSmooth();
   text(sentence, n1*width, n2*height);
   }
   */  /*  {
   strokeWeight(min(width, height)/10);
   float v1=.2, v2=.1, v3=.8, v4=.7;
   smooth();
   float v5=dist(v1*width, v2*height, v3*width, v4*height);
   {
   
   for (float i = 0; i <= v5; i++)
   {
   float x = lerp(v1*width, v3*width, i/v5) ;
   float y = lerp(v2*height, v4*height, i/v5);
   stroke(0, map(i, 0, v5, 1, 255));
   point(x, y);
   }
   }
   }
   */

  rectMode(CORNER);
  String s = "2016  LIVE";
  PFont font3=loadFont("AgencyFB-Bold-255.vlw"); 
popup(.9, .5, s, (min(width, height)/20), color(255), font3) ;
  save("diagonalck ("+llll+").png");
  // save("diagonalc ("+llll+").tiff");
  //save("diagonalck ("+llll+").jpg");
}
float i, j, spacer=10, fs=900, //font size 
n=10, //length of plus 
t=n*.5;
color  c1= color(0, 143, 229), //background upper gradient 
c2= color(255, 255, 0, 200), //background lower gradient 
c3= color(144, 79, 144), //dot colour 
c5= color(49, 164, 255, 200), //text colour 
c6= color(255, 50, 50, 50);
void quadrants()
{
  float v1=.5, v2=.5, v3=1.2, v4=1.2;

  noSmooth();
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

  noSmooth();

  noFill();
  {  
    color icolour1=color(122, 0, 255, 100);
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
  stroke(c6);
  strokeWeight(t); 
  line(i-n, j-n, i+n, j+n);// up to down  
  line(i-n, j+n, i+n, j-n);// down to up
}
void popup(float n1, float n2, String s, float m, color c, PFont font3) {

  fill(220, 200);
  // rect( width*n1-m*s.length()/2/2, height*n2-2*m/2, m*s.length()/2, 2* m, min(width, height)/200);
  textAlign(CENTER, CENTER);
  textFont(font3, m);
  fill(c);
  smooth();
  text(s, width*n1-m*s.length()/2, height*n2-2*m/2, m*s.length(), 2* m);
}

