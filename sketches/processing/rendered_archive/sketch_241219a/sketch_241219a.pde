import com.hamoid.*;

PImage img;
float zoom = 1.0;
VideoExport videoExport;
int fps = 120;        // Frames per second
int duration = 5;     // Duration in seconds
boolean recording = false;

void setup() {
  size(800, 600, P3D);
  img = loadImage("image.png");
  img.resize(img.width / 3, img.height / 3);

  videoExport = new VideoExport(this, "output.mp4");
  videoExport.setFrameRate(fps);


  videoExport.startMovie();
  recording = true;
}

void draw() {
  background(255);
  translate(width / 2, height / 2, -100);
  scale(zoom);
  rotateY(map(frameCount, 0, fps * duration, 0, TWO_PI));

  beginShape(POINTS);
  strokeWeight(2);
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      color c = img.get(x, y);
      float z = map(brightness(c), 0, 255, 200, 0);
      stroke(c);
      vertex(x * 2 - img.width, y * 2 - img.height, -z);
    }
  }
  endShape();

  if (recording) {
    videoExport.saveFrame();
    // Draw a red recording indicator
    fill(255, 0, 0);
    noStroke();
    ellipse(width - 30, 30, 20, 20);
  }

  // Stop recording after the specified duration
  if (recording && frameCount >= fps * duration) {
    videoExport.endMovie();
    recording = false;
    println("Video saved!");
    exit();
  }
}

void mouseWheel(MouseEvent event) {
  zoom = constrain(zoom + event.getCount() * 0.05, 0.2, 5.0);
}
