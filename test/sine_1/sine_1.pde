float a = 0.0, b = 4, i, j;
float inc = radians(12), re=radians(15);

void setup() {
  size( 7860/3, 4320/3);//size( 7860/3, 4320/3);
  //background(220, 220, 220);
  stroke(35, 35, 35);
  strokeWeight(50);
  //for (int i = 0; i < 5000; i=i+10) //1
  for (int i = 0; i <width; i=i+100)
  {
    //line(i, height/2, i, height/2+sin(a)*height/20*9);  //2
    //point(i, height/2+sin(a)*height/20*9);//3
    //point(i, height/2+sin(b)*height/20*5);//4
    //point(i, height/2+sin(a)*height/20*9);//5
    a = a + inc;
    for (j = 0; j < b; j++)
    {

      point(i, height/2+sin(a+j*re)*height/2*.25*(1.0-i/width));//5
    }
    //a = a + inc;
    //b=b+inc+re;//4
    //b=b+re;//5
  }
  save("lat");
}
//void draw()
/*{
 for (int i = 0; i < 500; i=i+4) {
 line(i, 50, i, 50+sin(a)*40.0);
 a = a + inc--;
 }
 }*/
