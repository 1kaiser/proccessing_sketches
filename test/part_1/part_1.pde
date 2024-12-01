a1=i+n*cos(rad);
a2=j+n*sin(rad);

b1=i-n*cos(rad);
b2=j+n*sin(rad);
stroke(255);
strokeWeight(40);
point(i, j);
strokeWeight(20);

void tls(float a1, float a2, float b1, float b2, int m)//triangle in logarithmic spiral 
{
  t2=rad;
  t1=rad+m*rotation;//
  t3=rad+(m+1)*rotation;///
  for (int o=0; o<100; o+=3)
  {
    c1=i+a*exp(b*t2)*cos(t1);///
    c2=j+a*exp(b*t2)*sin(t1);///
    triangle(a1, a2, b1, b2, c1, c2);
    d1=i+a*exp(b*t2)*cos(t3);///
    d2=j+a*exp(b*t2)*sin(t3);///
    triangle(b1, b2, c1, c2, d1, d2);///
    a1=c1;///
    a2=c2;///

    b1=d1;///
    b2=d2;///

    t1+=rad;//
    t2+=rad;
    t3+=rad;///
  }
}
