int i, j, s =1600;/*spacer for heart*/
float p;
color c=#FFCD43;
void setup() 
{
  background(#FFFF4D);
  size(7860, 4320);
  for (; s >400; s = s-s/4)
  {
    heart();
  }


  save("diagonal.tif");
}

void heart()
{

  p=s*sqrt(2);

  i=width/2;
  j=height/2;
  c=gradient();
  stroke(c);
  fill(c);
  smooth();
  quad(i, j-s, i+s, j, i, j+s, i-s, j);
  arc(i-s/2, j-s/2, p, p, PI-QUARTER_PI, TWO_PI-QUARTER_PI);//left arc: arc(a, b, c, d, start, stop, mode);
  arc(i+s/2, j-s/2, p, p, PI+QUARTER_PI, TWO_PI+QUARTER_PI);//right arc
}
color gradient()
{
  c=c-c/4;
  return c;
}

