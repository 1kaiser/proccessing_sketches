float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;

void setup() 
{
  background(255, 0, 0);
  size( 7860, 4320);
  noSmooth();
  //  col(); 
  //back();
  { 
    icolour1=color(255);
    icolour2=color(255, 255, 0, 150);
    float n1=.5;
    float n2=.5;
    float q=30;
    for (float p=q/2; p<sqrt (2)*dist (0, 0, width, height); p=p+q)
    {
      stroke(lerpColor(icolour1, icolour2, map(p, 0, sqrt (2)*dist (0, 0, width, height), 0, 1)));
      //fill(lerpColor(icolour1, icolour2, map(p, 0, dist (0, 0, i, j), 0, 1)));
      strokeWeight(20);
      smooth();
      line(n1*width+p-width/2, n2*height-width/2, n1*width+p+width/2, n2*height+width/2);
      line(n1*width-p-width/2, n2*height-width/2, n1*width-p+width/2, n2*height+width/2);
      line(n1*width+p+width/2, n2*height-width/2, n1*width+p-width/2, n2*height+width/2);
      line(n1*width-p+width/2, n2*height-width/2, n1*width-p-width/2, n2*height+width/2);
    }
  }

  {
    noStroke();
    float n1=.5;
    float n2=.45;
    icolour1=color(255, 255, 0, 40);
    icolour2=color(255, 150, 0, 40);
    float dia=min(height, width)/5*1.2*.5/5;
    fill(255); 
    // ellipse( width*n1, height*n2, dia, dia);
    float gap=radians(30);
    /*    for (float n=180-0; n>0; n=n-1)
     {
     noStroke();
     
     fill(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
     arc( width*n1, height*n2, dia, dia, -radians(n)+gap, +radians(n)+gap, OPEN);
     arc( width*n1, height*n2, dia, dia, -radians(n)+gap*2, +radians(n)+gap*2, OPEN);
     }*/
    n1=.5;
    n2=.5; 
    fill(255, 0, 0); 
    ellipse( width*n1, height*n2, dia*1.2, dia*1.2);
    n1=.54;
    n2=.56; 
    fill(50); 
    //  ellipse( width*n1, height*n2, dia*1.1, dia*1.1);

    n1=.46;
    n2=.56; 
    fill(50); 
    // ellipse( width*n1, height*n2, dia*1.1, dia*1.1);
  } 

  lip();
  /* {
   
   float n1=.53;
   float n2=.63;
   icolour1=color(255, 255, 0, 40);
   icolour2=color(255, 150, 0, 40);
   float dia=min(height, width)/5*1.2*.5/2;
   fill(255); 
   ellipse( width*n1, height*n2, dia, dia);
   noFill(); 
   float gap=radians(30);
   for (float n=180-0; n>0; n=n-1)
   {
   stroke(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
   arc( width*n1, height*n2, dia, dia, -radians(n)+gap, +radians(n)+gap, OPEN);
   arc( width*n1, height*n2, dia, dia, -radians(n)+gap*2, +radians(n)+gap*2, OPEN);
   }
   }*/
  /* {
   noStroke();
   float n1=.55, n2=.54;
   float dia=min(height, width)/5*1.2*.5/5;
   fill(50); 
   ellipse( width*n1, height*n2, dia, dia);
   n1=.45;
   n2=.54;
   ellipse( width*n1, height*n2, dia, dia);
   } 
   */

  /*  {    
   { 
   noStroke();
   float n1=.5;
   float n2=.5;
   icolour1=color(255, 255, 0, 8);
   icolour2=color(255, 150, 0, 8);
   
   float dia=min(height, width)/5*1.2/3*2/3*.5*.8;
   for (float n0=0+15; n0<360+15; n0=n0+30) 
   {
   float s1=dia*5;
   float a1=s1*cos(radians(n0));
   float a2=s1*sin(radians(n0));
   float dia1=lerp(dia*1, dia*2, map(s1, width*.05, width*.8, 0, 1));
   float gap=radians(60);
   fill(255);
   ellipse( width*n1+a1, height*n2+a2, dia1, dia1);
   
   for (float n=180-0; n>0; n=n-5)
   {
   noStroke();
   
   fill(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
   arc( width*n1+a1, height*n2+a2, dia1, dia1, -radians(n)-gap/2+radians(n0), +radians(n)-gap/2+radians(n0), OPEN);
   arc( width*n1+a1, height*n2+a2, dia1, dia1, -radians(n)+gap/2+radians(n0), +radians(n)+gap/2+radians(n0), OPEN);
   }
   }
   }
   }
   {    
   { 
   noStroke();
   float n1=.5;
   float n2=.5;
   icolour1=color(255, 255, 0, 10);
   icolour2=color(255, 150, 0, 10);
   
   float dia=min(height, width)/5*1.2/3*2/3*.5;
   for (float n0=360-0; n0>0; n0=n0-30) 
   {
   float s1=dia*4.5;
   float a1=s1*cos(radians(n0));
   float a2=s1*sin(radians(n0));
   float dia1=lerp(dia*1, dia*2, map(s1, width*.05, width*.8, 0, 1));
   float gap=radians(60);
   fill(255);
   ellipse( width*n1+a1, height*n2+a2, dia1, dia1);
   
   for (float n=180-0; n>0; n=n-5)
   {
   noStroke();
   
   fill(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
   arc( width*n1+a1, height*n2+a2, dia1, dia1, -radians(n)-gap/2+radians(n0), +radians(n)-gap/2+radians(n0), OPEN);
   arc( width*n1+a1, height*n2+a2, dia1, dia1, -radians(n)+gap/2+radians(n0), +radians(n)+gap/2+radians(n0), OPEN);
   }
   }
   }
   }
   
   {    
   { 
   noStroke();
   float n1=.5;
   float n2=.5;
   icolour1=color(255, 0, 0, 10);
   icolour2=color(255, 0, 130, 10);
   
   float dia=min(height, width)/5*1.2/3*2/3*.5*.1;
   for (float n0=360-0; n0>0; n0=n0-30) 
   {
   float s1=dia*4.5*10*1.2;
   float a1=s1*cos(radians(n0));
   float a2=s1*sin(radians(n0));
   float dia1=lerp(dia*1, dia*2, map(s1, width*.05, width*.8, 0, 1));
   float gap=radians(60);
   fill(255);
   ellipse( width*n1+a1, height*n2+a2, dia1, dia1);
   
   for (float n=180-0; n>0; n=n-5)
   {
   noStroke();
   
   fill(lerpColor(icolour2, icolour1, map(n, 0, 180, 0, 1)));
   arc( width*n1+a1, height*n2+a2, dia1, dia1, -radians(n)-gap/2+radians(n0), +radians(n)-gap/2+radians(n0), OPEN);
   arc( width*n1+a1, height*n2+a2, dia1, dia1, -radians(n)+gap/2+radians(n0), +radians(n)+gap/2+radians(n0), OPEN);
   }
   }
   }
   }*/
  /* {  
   noFill();
   //fill(255, 255, 0, 100);
   float h1=min(height, width)/9;
   //float s1=min(height, width)/30;
   float s1=0;
   float b=.9;
   float a=sin(h1/2)/3*min(height, width)/4/5;
   strokeWeight(min(height, width)/300);
   stroke( 0);
   strokeJoin(ROUND);
   float g = .09; 
   float rad = radians(g);
   float   t2=rad; 
   float n1=.5;
   float n2=.47;
   
   { 
   float n=-90;
   beginShape();
   for (int o=0; o<1000; o++)
   {
   float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
   float c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);
   t2+=rad;
   curveVertex(c1, c2);
   }
   
   for (int o=0; o<1000; o++)
   {
   float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
   float  c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
   t2-=rad;
   curveVertex(c1, c2);
   }
   n=90;  
   b=-1;
   for (int o=0; o<1000; o++)
   {
   float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
   float c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);
   t2+=rad;
   curveVertex(c1, c2);
   }
   
   for (int o=0; o<1000; o++)
   {
   float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
   float  c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
   t2-=rad;
   curveVertex(c1, c2);
   }
   endShape();
   }
   }
   */
  {

    noFill(); 
    float h1=min(height, width)/11;
    float s1=min(height, width)/5*1.2/8;


    float a=sin(h1/2)/3*min(height, width)/2.15/25;
    strokeWeight(min(height, width)/250);
    stroke( 0 );
    strokeJoin(ROUND);
    float g = .09; 
    float rad = radians(g);
    float   t2=rad; 
    float b=2;
    float n1=.5;
    float n2=.62;
    { 
      n2=.58;
      float n=-30;
      beginShape();
      for (int o=0; o<1000; o++)
      {    

        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
        float c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);
        curveVertex(c1, c2); 
        t2+=rad;
      }  
      endShape();
    }
    { 
      float n=210;
      beginShape();  
      for (int o=0; o<1000; o++)
      {
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
        float  c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
        curveVertex(c1, c2);
        t2-=rad;
      } 
      endShape();
    }
  }
  { 
    noFill(); 
    float h1=min(height, width)/11; 
    stroke( 0 );

    float s1=min(height, width)/5*1.2/5;
    float a=sin(h1/2)/3*min(height, width)/2.15/6;
    float g = .09; 
    float rad = radians(g);
    float   t2=rad; 
    float b=.8;
    float n1=.5;
    float n2=.52;
    strokeWeight(min(height, width)/250);
    stroke( 0 );
    strokeJoin(ROUND);  
    strokeWeight(min(height, width)/300);
    {
      float n=10;
      beginShape();
      for (int o=0; o<1000; o++)
      {         
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
        float  c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);

        curveVertex(c1, c2);
        t2+=rad;
      } 
      endShape();
    }
    { 
      float n=170;
      beginShape();
      for (int o=0; o<1000; o++)
      {
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
        float c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);

        curveVertex(c1, c2);
        t2-=rad;
      }
      endShape();
    }
  }



  save("diagonal5.png");
  // save("diagonal5.tiff");
  //  save("diagonal5.jpeg");
}
void lip()
{ 
  {  
    // noFill();
    fill(255, 0, 0);
    float h1=min(height, width)/9;
    float s1=0;

    float b=-.5;
    float a=sin(h1/2)/3*min(height, width)/.35/30;
    strokeWeight(min(height, width)/700);
    //stroke( 0);
    noStroke();
    strokeJoin(ROUND);
    float g = .09; 
    float rad = radians(g);
    float   t2=rad; 
    float n1=.5;
    float n2=.68;

    { 
      float n=-90;
      beginShape();
      b=-2;
      for (int o=0; o<1000; o++)
      {
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
        float c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);
        t2+=rad;
        curveVertex(c1, c2);
      }

      for (int o=0; o<1000; o++)
      {
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
        float  c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
        t2-=rad;
        curveVertex(c1, c2);
      }    


      n=90;  
      b=-.7;
      for (int o=0; o<700; o++)
      { 
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
        float c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);

        t2+=rad;
        curveVertex(c1, c2);
      } 
      for (int o=0; o<700; o++)
      {          
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
        float c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);

        t2-=rad; 
        curveVertex(c1, c2);
      }
      endShape();
    }
  }
}


void back()
{ 
  {  
    // noFill();
    fill(255);
    float h1=min(height, width)/9;
    float s1=0;

    float b=-.5;
    float a=sin(h1/2)/3*min(height, width)/.35/3;
    strokeWeight(min(height, width)/700);

    noStroke();
    // stroke( 0);
    strokeJoin(ROUND);
    float g = .09; 
    float rad = radians(g);
    float   t2=rad; 
    float n1=.5;
    float n2=.52;

    { 
      float n=-90;
      beginShape();
      b=-2;
      for (int o=0; o<1000; o++)
      {
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
        float c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);
        t2+=rad;
        curveVertex(c1, c2);
      }

      for (int o=0; o<1000; o++)
      {
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
        float  c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
        t2-=rad;
        curveVertex(c1, c2);
      }    
      a=sin(h1/2)/3*min(height, width)/.35/4.5;
      n2=.5;
      n=90;  
      b=.2;
      for (int o=0; o<1000; o++)
      {
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
        float c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);
        t2+=rad;
        curveVertex(c1, c2);
      }

      for (int o=0; o<1000; o++)
      {
        float c1=n1*width+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
        float  c2=n2*height+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
        t2-=rad;
        curveVertex(c1, c2);
      }
      endShape();
    }
  }
}
void col()
{
  {
    float n1, n2;
    n1=1.3;
    n2=.5;

    icolour1=color(255, 0, 0, 100);
    icolour2=color(0, 0, 255, 100);
    int cmin=100, cmax=255, alp=200;
    float dia=min(height, width)/5*1.2*20;
    float diff=.1;
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

      arc( width*n1, height*n2, dia, dia, radians(n), radians(n+diff), PIE);
      //  ellipse( width*n1, height*n2, dia, dia);
    }
  }
}

