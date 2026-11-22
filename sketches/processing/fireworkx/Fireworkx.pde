PFont font, font1;
int fontsize = 90;

float angleRotate = 380.0;
String
  s = "\nYOU ARE\nWORTHY\nOF LOVE",
  t = "HAPPY\nNEW YEAR\n2022";


float an1=0, an2=90, h=45, ang1=radians(an1), ang2=radians(an2),
  rotation=radians(h), tang, n;
String sentence;//text in the centre
color icolour, icolour1, icolour2;



class Fire {
  float x;
  float y;
  float vx;
  float vy;
  color col;
  float lifetime = 700;

  Fire(float x, float y, float vx, float vy, color col) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.col = col;
  }

  void draw() {
    if (lifetime-50>0) {
      noStroke();
      fill(col, lifetime-50);
      ellipse(x, y, random(4, 10), random(4, 10));
      lifetime -= 0.5;
    }
  }

  void update() {
    vy += G;
    x += vx;
    y += vy;
  }
}

ArrayList<Fire> fireworks = new ArrayList();
final float G = 0.04;
int god=4320;


void setup() {
  size(3840, 2160, P3D);
  //surface.setResizable(true);
  frameRate(90);

  font = loadFont("CenturyGothic-255.vlw");
  font1 = loadFont("CenturyGothic-Bold-255.vlw");


  // Set text characteristics
  textFont(font);

  textAlign(CENTER, CENTER);
  int concentration = 1000;
  lightSpecular(1, 1, 1);
  spotLight(255, 0, 0, 200, 200, 1600,
    0, 0, -1, PI/16, concentration);
}

void draw() {
  noStroke();
  background(angleRotate/360*255);
  for (int i = 0; i < fireworks.size(); i++) {
    fireworks.get(i).update();
    fireworks.get(i).draw();
  }
  //filter(BLUR, 3);
  {


    strokeWeight(4);
    //stroke(100, angleRotate/360*255, angleRotate/360*255);
    //if(angleRotate<=360){}

    float xx;
    if (angleRotate<270) {
      xx=map(angleRotate, 0, 270, fontsize*0.4*s.length(), 0);
    } else {
      xx=0;
    }
    push();
    translate(width/2, height/2, -height);
    if (angleRotate<=360) {
      rotate(radians(angleRotate));
    }
    if (angleRotate<380) {
      textFont(font);
      fill(255, 230, 0, map(angleRotate, 360, 380, 255, 0));
      textSize(fontsize+angleRotate/360*100);
      //text(int(angleRotate) % 360+" "+s+" ", xx, 0, angleRotate/360*height);
      text(s, xx, 0, angleRotate/360*height);
    }
    if (angleRotate>380&&angleRotate<500) {
      textFont(font1);
      fill(255, 230, 0, map(angleRotate, 380, 440, 0, 255));
      if (angleRotate>440) {
        fill(255, 230, 0, map(angleRotate, 440, 500, 255, 0));
      }
      textSize(fontsize+(380/360-angleRotate)*100);
      text(t, 0, 0, angleRotate/360*height);
    }
    //line(0, 0, --fontsize*0.4*s.length(), 0);
    pop();
    noFill();
    angleRotate += .5;
    if (int(angleRotate)%30==0&&angleRotate<270) {
      ogogo();
    }
    if (int(angleRotate)==380) {
      ogogo();
    }
    stroke(255, 0, 0);
    strokeWeight(8);
    //point(width/2, height/2);
  }
  if (angleRotate>500) {
    //lip();
    eyes();
  }
  if (angleRotate>600) {
    exit();
  }

  saveFrame("fr/line-######.png");
}

void ogogo() {
  //fireworks.clear();
  for (int xx = 0; xx < 10; xx++) {

    color c = color(random(50, 255), random(50, 255), random(50, 255), random(50, 255));
    int numFires = (int)random(50, 100);
    for (int i=0; i<numFires; i++) {
      float r = random(0, TWO_PI);
      float R = random(0, 4);
      fireworks.add(new Fire(random(0.0*width, 1.0*width), random(-0.1*height, 0.0*height), R*sin(r), R*cos(r), c));
      // fireworks.add(new Fire(mouseX,mouseY, R*sin(r), R*cos(r), c));
    }
  }
}

void eyes() {
  scale(0.5);
  translate(-4320/2+width, -4320/2+height);
  {

    int i, // x axis
      j, //y axis
      o, m; // important parameter for control of propagating triangles


    float
      n=4320/5*0.02, // central circle radius
      b=0.4, // tightness of curve
      t1, t2, a1, a2, b1, b2, c11, c22, c1, c2, d1, d2, e1, e2,
      g = .09,
      rad = radians(g);
    float n1=.5, n2=.5;
    i=width/2;
    j=height/2;

    float h1=30;
    //float s1=500;//radius control   min(height, width)/5*1.2*.5/5;
    float s1=4320/5*0.05;//radius control

    float a=s1*sin(h1/2);

    stroke(0);
    strokeWeight(40);
    //point(i, j);
    strokeWeight(2);
    strokeJoin(MITER);
    //noFill();
    noStroke();
    noSmooth();

    t2=rad;
    color[] icolourx={
      //color(255, 60, 200, 25),
      color(200, 240),
      color(225, 230),
      color(250, 220)

    };
    float[] aaa={
      s1*1.20,
      s1*1.00,
      s1*0.90
    };
    float[] PetalRotation={
      0,
      h1/2,
      0
    };
    int count=int(aaa.length);
    while (count>0) {
      count--;
      fill(icolourx[count]);
      s1=aaa[count];
      // a=s1*sin(h1/2);
      for (float nx=h1/2+PetalRotation[count]; nx<360+PetalRotation[count]; nx=nx+h1)
      {
        beginShape();
        for (int ox=0; ox<1000; ox++)
        {
          c1=n1*god+s1*cos(radians(nx))+a*exp(b*t2)*cos(t2+PI/2+radians(nx)+PI);
          c2=n2*god+s1*sin(radians(nx))+a*exp(b*t2)*sin(t2+PI/2+radians(nx)+PI);
          t2+=rad;
          curveVertex(c1, c2);
        }
        for (int ox=0; ox<1000; ox++)
        {
          c1=n1*god+s1*cos(radians(nx))+a*exp(b*t2)*cos(-t2-PI/2+radians(nx)+PI);
          c2=n2*god+s1*sin(radians(nx))+a*exp(b*t2)*sin(-t2-PI/2+radians(nx)+PI);
          t2-=rad;
          curveVertex(c1, c2);
        }
        endShape(CLOSE);
      }
    }


    color icolour1=color(255, 255, 0);
    color icolour2=color(255, 150, 0);

    for (n=180; n>0; n=n-.1)
    {
      noStroke();
      fill(lerpColor(icolour1, icolour2, map(n, 0, 180, 0, 1)));
      // strokeWeight(50);
      noSmooth();
      arc(n1*god, n2*god, 3*s1, 3*s1, 2*PI-PI/2 -radians(n), 2*PI-PI/2+radians(n), OPEN);
      // rotation++;
    }
  }
  {

    noFill();
    float h1=4320/11;
    float s1=4320/5*1.2/8;


    float a=sin(h1/2)/3*4320/2.15/25;
    strokeWeight(god/250);
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
        float c1=n1*god+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
        float c2=n2*god+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);
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
        float c1=n1*god+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
        float c2=n2*god+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);
        curveVertex(c1, c2);
        t2-=rad;
      }
      endShape();
    }
  }
  {
    noFill();
    float h1=4320/11;
    stroke( 0 );

    float s1=4320/5*1.2/5;
    float a=sin(h1/2)/3*4320/2.15/6;
    float g = .09;
    float rad = radians(g);
    float   t2=rad;
    float b=.8;
    float n1=.5;
    float n2=.52;
    strokeWeight(god/250);
    stroke( 0 );
    strokeJoin(ROUND);
    strokeWeight(god/300);
    {
      float n=10;
      beginShape();
      for (int o=0; o<1000; o++)
      {
        float c1=n1*god+s1*cos(radians(n))+a*exp(b*t2)*cos(-t2-PI/2+radians(n)+PI);
        float c2=n2*god+s1*sin(radians(n))+a*exp(b*t2)*sin(-t2-PI/2+radians(n)+PI);

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
        float c1=n1*god+s1*cos(radians(n))+a*exp(b*t2)*cos(t2+PI/2+radians(n)+PI);
        float c2=n2*god+s1*sin(radians(n))+a*exp(b*t2)*sin(t2+PI/2+radians(n)+PI);

        curveVertex(c1, c2);
        t2-=rad;
      }
      endShape();
    }
    lip();
  }
}
void lip() {

  // noFill();
  fill(255, 0, 0);
  float hooo = 4320 / 9;
  float sooo = 0;

  float booo = -.5;
  float aooo = sin(hooo / 2) / 3 * 4320 / .35 / 30;
  strokeWeight(god / 700);
  //stroke( 0);
  noStroke();
  strokeJoin(ROUND);
  float gooo = .09;
  float radooo = radians(gooo);
  float t2ooo = radooo;
  float n1ooo = .5;
  float n2ooo = .68;

  {
    float nooo = -90;
    beginShape();
    booo = -2;
    for (int o = 0; o < 1000; o++) {
      float c1ooo = n1ooo * god + sooo * cos(radians(nooo)) + aooo * exp(booo * t2ooo ) * cos(t2ooo + PI / 2 + radians(nooo) + PI);
      float c2ooo = n2ooo * god + sooo * sin(radians(nooo)) + aooo * exp(booo * t2ooo ) * sin(t2ooo + PI / 2 + radians(nooo) + PI);
      t2ooo += radooo;
      curveVertex(c1ooo, c2ooo);
    }

    for (int o = 0; o < 1000; o++) {
      float c1ooo = n1ooo * god + sooo * cos(radians(nooo)) + aooo * exp(booo * t2ooo ) * cos(-t2ooo - PI / 2 + radians(nooo) + PI);
      float c2ooo = n2ooo * god + sooo * sin(radians(nooo)) + aooo * exp(booo * t2ooo ) * sin(-t2ooo - PI / 2 + radians(nooo) + PI);
      t2ooo -= radooo;
      curveVertex(c1ooo, c2ooo);
    }


    nooo = 90;
    booo = -.7;
    for (int o = 0; o < 700; o++) {
      float c1ooo = n1ooo * god + sooo * cos(radians(nooo)) + aooo * exp(booo * t2ooo ) * cos(t2ooo + PI / 2 + radians(nooo) + PI);
      float c2ooo = n2ooo * god + sooo * sin(radians(nooo)) + aooo * exp(booo * t2ooo ) * sin(t2ooo + PI / 2 + radians(nooo) + PI);

      t2ooo += radooo;
      curveVertex(c1ooo, c2ooo);
    }
    for (int o = 0; o < 700; o++) {
      float c1ooo = n1ooo * god + sooo * cos(radians(nooo)) + aooo * exp(booo * t2ooo ) * cos(-t2ooo - PI / 2 + radians(nooo) + PI);
      float c2ooo = n2ooo * god + sooo * sin(radians(nooo)) + aooo * exp(booo * t2ooo ) * sin(-t2ooo - PI / 2 + radians(nooo) + PI);

      t2ooo -= radooo;
      curveVertex(c1ooo, c2ooo);
    }
    endShape();
  }
}
