float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;

void setup() 
{
  background(255);
  // size( 8192/4, 4320/4);
  size( 7860, 4320);
  noSmooth();
  //  col(); 
  //back();
  {
    noFill();
    strokeWeight(2);
    for (float w=width/2-height*2/3; w<height*2/3; w++) {
      for  (float v=height/2-height*2/3/2; v<height*2/3; v++) {
        // stroke(255); 
        stroke(lerpColor(color(255, 0, 0, random(random(200, 230), 255)), color(255, 255, 0, random(random(10, 40), 0)), map(dist(width, 0, w, v), 0, dist(0, 0, width, height), 0, 1)));
        point(w, v);
      }
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
    strokeWeight(min(height, width)/250);
    stroke(255); 
    noFill();
    // ellipse( width*n1, height*n2, dia*1.2, dia*1.2);
    n1=.54;
    n2=.56; 
    fill(50); 
    //  ellipse( width*n1, height*n2, dia*1.1, dia*1.1);

    n1=.46;
    n2=.56; 
    fill(50); 
    // ellipse( width*n1, height*n2, dia*1.1, dia*1.1);
  } 




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
    for (float y1=-y0; y1<=y0; y1+=y0) { 
      for (float x1=-y0; x1<=y0; x1+=y0) {  
        sentence=""+letters[no]+""; 

        if (letters[no] !='d') {
          fill(color(255, 0, 0)); 
          smooth(); 
          ellipse(i+x1, j+y1, 2*y2/20/3, 2*y2/20/3); 

          // font=loadFont("AgencyFB-Bold-255.vlw"); 
          // textFont(font, y2/13); 
          textAlign(CENTER, CENTER); 
          fill(255, 255, 255); 
          smooth(); 

          //text(sentence, i+x1, j+y1);}
        }  
        no++;
      }
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

