int l=100;
float a = 0.0, b = 8, i, j, k, m1=0, m2=0, m3;
float inc = radians(15), re=radians(30);

void setup() {
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  //background(220, 220, 220);
  stroke(35, 35, 35);
  noSmooth();
  strokeWeight(50);
  section();

  k=width;
  //for (int i = 0; i < 5000; i=i+10) //1
  for (i = m1-l; i <m3+l; i=i+l)
  {
    //line(i, height/2, i, height/2+sin(a)*height/20*9);  //2
    //point(i, height/2+sin(a)*height/20*9);//3
    //point(i, height/2+sin(b)*height/20*5);//4
    //point(i, height/2+sin(a)*height/20*9);//5
    // k--;
    i+=l/b;
    a = a + inc;
    for (j = 0; j < b; j++)
    {

      point(i, height/2+sin(a+j*re)*height/2*(k-i)/k);//5
    }
    //a = a + inc;
    //b=b+inc+re;//4
    //b=b+re;//5
  }
  save("lat");
}
void section()
{
  m1=random(0, width);
  m2=random(0, width);
  while (m1==0||m2==0|| (max (m1, m2)-min(m1, m2))<5*l|| (max (m1, m2)-min(m1, m2))>7*l  )
  {
    section();
  }
  m3=max(m1, m2);
  m1=min(m1, m2);
}
//void draw()
/*{
 for (int i = 0; i < 500; i=i+4) {
 line(i, 50, i, 50+sin(a)*40.0);
 a = a + inc--;
 }
 }*/
