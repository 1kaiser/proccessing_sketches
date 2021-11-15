float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2), 
rotation=radians(h), tang, n;
PFont font, font1, font2;
String sentence;//text in the centre
color icolour, icolour1, icolour2;

void setup() 
{
  background(0, 255, 130);
  size( 8192, 4320);
  // size( 7860, 4320);
  noSmooth();

  {  
    smooth();
    icolour1=color(255);
    icolour2=color(255, 130);
    float n1=0;
    float n2=0;
    float q=30;
    for (float p=q/2; p<sqrt (2)*dist (0, 0, width, height); p=p+q)
    {
      stroke(lerpColor(icolour1, icolour2, map(p, 0, sqrt (2)*dist (0, 0, width, height), 0, 1)));
      //fill(lerpColor(icolour1, icolour2, map(p, 0, dist (0, 0, i, j), 0, 1)));
      strokeWeight(20);

      line(n1*width+p-width, n2*height-width, n1*width+p+width, n2*height+width);
      line(n1*width-p-width, n2*height-width, n1*width-p+width, n2*height+width);
      line(n1*width+p+width, n2*height-width, n1*width+p-width, n2*height+width);
      line(n1*width-p+width, n2*height-width, n1*width-p-width, n2*height+width);
    }
  }
  //  arter();
  FDAAA();
  save("diagonal5.png");
  // save("diagonal5.tiff");
  //  save("diagonal5.jpeg");
}
void FDAAA()
{ 
  float i, j; //font size 
  String lines[] = loadStrings("list2.txt");
  font=loadFont("MicrosoftJhengHeiLight-255.vlw");
  float squareheight=max( min(width, height)/80, 11);
  strokeWeight(squareheight);
  textFont(font, squareheight);
  int po=0;
  for (int o=0; o<lines.length; o++)
  {
    po=max(lines[o].length(), po);
  }
  float n=0;
  //  n=n+ min(po*squareheight, 280); //length of plus 
  n=n+ min(squareheight, 280);
  float m=0; 
  m=m+n/3; 
  int index = int(random(lines.length));
  int k =0;
  /// fill(100);
  for (j=0; j <height; j+=n) {
    for (i=0; i <width; i+=n) {
      if (k<lines[index].length()) {
        fill(sen(i, j));
        text(c_return(lines[index].charAt(k)), i, j) ;  
        k++;
      } else {
        k=0;
        index = int(random(lines.length));
      }
    }
  }
} 
color sen(float i, float  j) {   
  color icolour1=color(20);
  color icolour2=color(100);
  float v1=.5, v2=0, v3=.5, v4=1;
  // line(v1*width, v2*height, v3*width, v4*height);
  float v5=dist(v1*width, v2*height, v3*width, v4*height);
  {  
    float v6=dist(i, j, v3*width, v4*height);
    //    float x = lerp(v1*width, v3*width, i/v5) ;
    //float y = lerp(v2*height, v4*height, j/v5);
    return color(lerpColor(icolour1, icolour2, map( v6, 0, v5, 0, 1)));
  }
}
void arter() {
  float k=0;
  float i, j; //font size 
  String line_size[] = loadStrings("list2.txt");
  font=loadFont("MicrosoftJhengHeiLight-255.vlw");
  float squareheight=max( min(width, height)/150, 11);
  int po=0;
  for (int o=0; o<line_size.length; o++)
  {
    po=max(line_size[o].length(), po);
  }
  float n=0;
  n=n+ min(po*squareheight, 280); //length of plus 
  float m=0;
  m=m+n/3;
  {
    float v1=.5, v2=.5, v3=1.5, v4=1.5;

    noSmooth();
    {
      {
        k=1;
        for (j=height*v2-m; j >height*v2-height*v4/2; j-=m) {
          if (k==1) {
            k--;
          } else {
            k++;
          }
          for (i=width*v1+n; i <width*v3/2+width*v1; i+=n) {
            aarter_compoents(i, j, n, m, k);
          }
        }
      }
      {
        k=0;
        for (j=height*v2; j >height*v2-height*v4/2; j-=m) {
          if (k==1) {
            k--;
          } else {
            k++;
          }
          for (i=width*v1; i >width*v1-width*v3/2; i-=n) {
            if (j==height*v2&&i==width*v1)
            {
              i-=n;
            }
            aarter_compoents(i, j, n, m, k);
          }
        }
      } 
      { 
        k=1;
        for (j=height*v2+m; j <height*v2+height*v4/2; j+=m) {
          if (k==1) {
            k--;
          } else {
            k++;
          }
          for (i=width*v1-n; i >width*v1-width*v3/2; i-=n) { 
            aarter_compoents(i, j, n, m, k);
          }
        }
      }
      {
        k=0;
        for (j=height*v2; j <height*v2+height*v4/2; j+=m) {
          if (k==1) {
            k--;
          } else {
            k++;
          }
          for (i=width*v1; i <width*v3/2+width*v1; i+=n) {
            aarter_compoents(i, j, n, m, k);
          }
        }
      }
    }
  }
}

void aarter_compoents(float i, float  j, float n, float m, float k)
{
  art(i, j, n, m, k);
}
void art(float i, float  j, float n, float m, float k)
{ 
  noStroke();
  noSmooth(); 
  {  
    {  
      {   
        color icolour1=color(0);
        color icolour2=color(100);
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
      textFont(font, max( min(width, height)/200, 11));
      strokeWeight(min(width, height)/100);
      textAlign(CENTER, CENTER);
      int index = int(random(lines.length));
      char data[]= {
        'C', 'C', 'C', 'P'
      };
      for (int o=0; o<lines[index].length (); o++) {
        data[o]=c_return(lines[index].charAt(o));
      } 
      String converted_line=new String(data);
      text(converted_line, i-n+1.5*n*k, j-m/2, n, m/2);
    }
  }
}
char c_return(char in)
{ 
  char t=' ';
  String alpha="ABCDEFGHIJKLMNOPQRSTUVWXYZ. ";
  if (in=='0') {
    t=alpha.charAt(27);
  } else if (in=='1') {
    t=alpha.charAt(26);
  } else if (in=='2') {
    t=alpha.charAt(0+r());
  } else if (in=='3') {
    t=alpha.charAt(3+r());
  } else if (in=='4') {
    t=alpha.charAt(6+r());
  } else if (in=='5') {
    t=alpha.charAt(9+r());
  } else if (in=='6') {
    t=alpha.charAt(12+r());
  } else if (in=='7') {
    t=alpha.charAt(15+r1());
  } else if (in=='8') {
    t=alpha.charAt(19+r());
  } else if (in=='9') {
    t=alpha.charAt(22+r1());
  }
  return t;
}
int r() {
  return int(random(0, 2));
}
int r1() {
  return int(random(0, 3));
}

