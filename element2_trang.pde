int i, j;

float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;


void setup() 
{
  background(255);
  size( 7860, 4320);

  noSmooth();
  {
    icolour2=color(0);
    icolour1=color(0);
    float sier=dist (0, 0, width, height);
    float l=sier*.4;
    float n3=.5; 
    float inc = radians(15), re=radians(30);
    noFill();
    float n1=1, n2=.5;
    strokeWeight(sier/200);
    for (float n=0; n<360; n+=2)
    { 

      float a1=n1*width+sier*1.1*cos(radians(n));
      float a2=n2*height+sier*1.1*sin(radians(n));
      stroke(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
      ellipse(a1, a2, dist (0, 0, width, height)*1.4,dist (0, 0, width, height) *1.4);
    }
  }
/*  {  
    float n1=.5;
    float n2=1.2;
    icolour1=color(0, 255, 0);
    icolour2=color(0, 255, 255);
    for (n=180; n>0; n=n-.1)
    {
      noStroke();
      fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
      // strokeWeight(50);
      noSmooth();
      arc(n1*width, n2*height, .4*width, .4*width, PI/2 -radians(n), PI/2+radians(n), OPEN);
      // rotation++;
    }
  }*/
//  xx();
  float n1=.5, n2=.5;
  float y11=min(width, height)/10;

  float s1=y11;
  for (float n=60; n<120; n=n+120)
  {
    float a1=n1*width+s1*cos(3*PI/2+radians(n));
    float a2=n2*height+s1*sin(3*PI/2+radians(n));

    float b1=n1*width+s1*cos(3*PI/2+radians(n+120));
    float b2=n2*height+s1*sin(3*PI/2+radians(n+120));
    float c1=n1*width+s1*cos(3*PI/2+radians(n+240));
    float c2=n2*height+s1*sin(3*PI/2+radians(n+240));
    noFill();
    stroke(color(255, 0, 0, 200));
    strokeWeight(50); 
    strokeJoin(MITER);
    noSmooth();
    // triangle(a1, a2, b1, b2, c1, c2);///
  }



  save("diagonal51.png");
  //  save("diagonal5.tif");
}

void xx()
{   
  float n1, n2;
  n1=1;
  n2=.5;

  icolour1=color(0, 255, 0, 40);
  icolour2=color(0, 255, 255, 40);
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
     */    //  dia=random(height*.2, height*.8);

    fill(lerpColor(icolour1, icolour2, map(abs(180-n), 0, 180, 0, 1)));
    arc( width*n1, height*n2, dia, dia, radians(n), radians(n+diff), PIE);
    //  ellipse( width*n1, height*n2, dia, dia);
  }
}

