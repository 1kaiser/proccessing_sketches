PImage img;

void setup() 
{
  img = loadImage("d.png");
  size( 1920, 1080);

  image(img, 0, 0, img.width/4, img.height/4);

  filter(BLUR, 20);
  save("d1.png");
  // save("diagonal6.tif");
}

