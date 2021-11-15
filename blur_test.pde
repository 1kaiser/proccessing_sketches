int l=100, p=500, c1=1, i1=5, i2;
float a=1, b=100, i, k, j=20, m1=0, m2=0, m3, n;
float inc = radians(15), re=radians(30);
String   sentence="5";
PFont font1;
color c;
PImage img;

void setup() {
  img = loadImage("leonardo-da-vinci.png");

  size( img.width, img.height);
  background(img);
  /* size( 7860, 4320);
   //size( 8192 , 5120);
   background(220, 220, 220);
   stroke(35, 35, 35);
   noSmooth();
   strokeWeight(2);
   // section();//6
   //  for ( i=0; i<b; i++)
   {
   // if (a<.2*height) {
   k=j;
   while (a<.2*height) 
   {
   c=lerpColor(color(35, 35, 35, 100), color(200, 200, 200, 1), map(a, 0, .20*height, 0, 1));
   while (k>=0)
   {
   section();
   for ( n=0; n<a; n++)
   {
   //stroke(color(0, 0, 0, 200));
   //strokeWeight(1);
   //fill(color(0, 0, 0, 20));
   fill(c);
   noSmooth();
   noStroke();
   ellipse(m1, m2, n, n);//central circle
   }
   k=k-1;
   }
   
   j=j-1;
   k=j;
   a+=5;
   //k--;
   }
   //a+=10;
   }
   a=5;
   while (a<.2*height) 
   {
   c=lerpColor(color(35, 35, 35, 50), color(200, 200, 200, 1), map(a, 0, .2*height, 0, 1));
   
   section();
   for ( n=0; n<a; n++)
   {
   //stroke(color(0, 0, 0, 200));
   //strokeWeight(1);
   //fill(color(0, 0, 0, 20));
   fill(c);
   noSmooth();
   noStroke();
   ellipse(m1, m2, n, n);//central circle
   }
   a+=20;
   }
   
   stroke(35, 35, 35, 200);
   noSmooth();
   strokeWeight(c1);
   strokeCap(PROJECT);
   if ((width/2)!=0)
   {
   i2=i1;
   } 
   if ((width/2)==0) {
   i2=0;
   }
   for (n=width/2; n>=-i1; n-=i1)
   {
   line(n-i2, height/2+p, n-i2, height/2-p);
   line(width/2+n+i2, height/2+p, width/2+n+i2, height/2-p);
   }
   stroke(35, 35, 35, 200);
   noSmooth();
   strokeWeight(1);
   */
  /* for (n=width/2; n>=width/2-; n-=2)
   {
   line(n-i2, height/2+p, n-i2, height/2-p);
   line(width/2+n+i2, height/2+p, width/2+n+i2, height/2-p);
   }
   */

  //k--;
  /* stroke(35, 35, 35);
   noSmooth();
   strokeWeight(50);
   
   fill(color(0, 0, 0, 240));
   noSmooth();
   ellipse(width/2, height/2, 2*sqrt(2)*250*sqrt (2), 2*sqrt(2)*250*sqrt (2));//central circle
   
   font1=loadFont("AgencyFB-Bold-255.vlw");
   textFont(font1, 250*sqrt (2)*2);
   textAlign(CENTER, CENTER);
   fill(255, 255, 255, 150);
   noSmooth();
   text(sentence, width/2, height/2);
   
   sentence="MY BEST\nWHAT'S YOURS\n";
   font1=loadFont("GillSansMT-ExtraCondensedBold-255.vlw");
   textFont(font1, 100);
   textAlign(CENTER, BOTTOM );
   fill(0);
   noSmooth();
   text(sentence, width/2, height);
   
   */
  //img=loadImage("View of Moon From Space Station_11124277114_o.JPG");
  // blend(img, 0, 125+1/2*img.height, img.width, 125+img.height, 0, 125+1/2*img.height, img.width, 125+img.height, ADD);
  // blend(img, 0, (img.height)/2-125, img.width, (img.height)/2+125, 0, 0, img.width, img.height, BLEND );
  // tint(#000000, 200);
  // image(img, 0, 0);

  sentence="YOUR";
  font1=loadFont("AgencyFB-Bold-255.vlw");
  textFont(font1, dist(0, 0, width, height)/20);
  textAlign(CENTER, CENTER);
  fill(255, 0, 0, 200);
  noSmooth();
  text(sentence, width/2, height*.1);

  save("NJNJNJvbvb.png");
}
/*void section()   //6
 {
 m1=random(0, width);
 m2=random(0, width);
/* while (m1==0||m2==0|| (max (m1, m2)-min(m1, m2))<5*l|| (max (m1, m2)-min(m1, m2))>7*l  )
 {
 section();
 }
 m3=max(m1, m2);
 m1=min(m1, m2);
 
 }
 */
