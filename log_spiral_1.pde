  a1=i+n*cos(rad);
  a2=j+n*sin(rad);

  b1=i-n*cos(rad);
  b2=j+n*sin(rad);
  stroke(255);
  strokeWeight(40);
  point(i, j);
  strokeWeight(20);
  t2=rad;
  t1=rad+rotation;
  noStroke();
  for (int o=0; o<100; o+=3)
  {
    line(a1, a2, b1, b2);
    stroke(255);
    a1=b1;
    a2=b2;
    c1=i+a*exp(b*t2)*cos(t1);
    c2=j+a*exp(b*t2)*sin(t1);
    t1+=rad;
    t2+=rad;
    b1=c1;
    b2=c2;
  }
