float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2),  //<>//
  rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;

void setup() 
{
  int llll=1;
  PImage  img = loadImage("c ("+llll+").jpg");
  int ll=2;

  // size( 8192, 5120);
  size( 3840, 2160);
  // size( 7680, 4320);



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
  //noSmooth();
  smooth();
  /* {
   icolour2=color(255,0,0,100);
   icolour1=color(255,255,0,100);
   float sier=min(height, width);
   float l=sier*.4;
   float n3=.5; 
   float inc = radians(15), re=radians(30);
   noFill();
   float n1=.5, n2=0;
   strokeWeight(sier/100);
   for (float n=0; n<360; n+=2)
   { 
   
   float a1=n1*width+sier*1.1*cos(radians(n));
   float a2=n2*height+sier*1.1*sin(radians(n));
   stroke(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
   ellipse(a1, a2, sier*4, sier*4 );
   }
   }*/

  /*{
   icolour1=color(19, 136, 8, 30);
   icolour2=color(255, 153, 51, 30);
   float sier=min(height, width)/10;
   float l=sier*.4;
   float n3=.5; 
   float inc = radians(15), re=radians(-90);
   noStroke();
   float n1=.5, n2=.5;
   for (float n=0; n<360; n+=5)
   { 
   
   float a1=n1*width+sier*1.1*cos(radians(n)+re);
   float a2=n2*height+sier*1.1*sin(radians(n)+re);
   fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
   ellipse(a1, a2, sier, sier);
   }
   }
   */

  {
    float n1, n2;
    n1=.5;
    n2=.5;

    icolour1=color(255,255,0, 40);
    icolour2=color(255,0,0, 40);
    color icolour3=color(255, 40);

    color icolour4=color(0, 40);
    int cmin=0, cmax=255, alp=255;
    float dia=min(height, width)/5*1.2;
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
      //  fill(icolour1);
      /*    {
       
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
       */      //  dia=random(height*.2, height*.8);

      fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
      arc( width*n1, height*n2, dia, dia, radians(n), radians(n+diff), PIE);
      //  ellipse( width*n1, height*n2, dia, dia);
    }

    /* {    
     float n=dia*.25, t=dia/30;
     stroke(255);
     strokeWeight(t);  
     strokeCap(ROUND);
     line(width*n1-n, height*n2-n, width*n1+n, height*n2+n);// up to down  
     line(width*n1-n, height*n2+n, width*n1+n, height*n2-n);// down to up
     }*/
    {
      String s = "The quick brown fox jumps over the lazy dog";

    //  float n3=.5, n4=.5;

      font=loadFont("MicrosoftJhengHeiLight-255.vlw");

      textFont(font, min(width, height)/40);
      color icolour1=color(255);
      color icolour2=color(255);
      float m=.1*min(width, height);
      rectMode(RADIUS);  
      ellipseMode(CENTER); 
      /*  fill(0, 130, 255);
       noStroke();
       ellipse(n1*width, n2*height, 2.5*m, 2.5*m);
       */


      stroke(255); 
      fill(255);
      strokeWeight(min(width, height)/100);

      textAlign(CENTER, CENTER);
      text(s, n1*width, n2*height, m, m);
    } 

    /* {
     float siz=min(width, height)/10;
     font=loadFont("AgencyFB-Bold-255.vlw");
     textFont(font, siz);
     textAlign(CENTER, CENTER);
     fill(0, 0, 128, 200);
     String   sentence1="69";
     text(sentence1, width*n1, height*n2);
     }
     */
  }

  /*  {    
   float y11=min(width, height)/8;
   float n1=.5, n2=.5;
   float s1=y11;
   //  noFill();
   //  stroke(0, 255, 180, 180);
   noFill();
   stroke(250);
   strokeWeight(min(width, height)/80); 
   strokeJoin(MITER);
   smooth();
   beginShape();
   for (float n=0; n<360; n=n+120)
   {
   float a1=n1*width+s1*cos(3*PI/2+radians(n));
   float a2=n2*height+s1*sin(3*PI/2+radians(n));
   
   vertex(a1, a2);///
   }
   endShape(CLOSE);
   }*/

  save("diagonal4.png");
  //  save("diagonal5.tiff");
  //  save("diagonal5.jpeg");
}