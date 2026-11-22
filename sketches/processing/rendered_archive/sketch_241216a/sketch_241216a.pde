import java.io.File;
import java.util.Arrays;
import gifAnimation.*;

GifMaker gifMaker;
String imageFolderPath; // Path to the folder containing images (now data folder)
String outputGifPath = "output.gif"; // Path to save the output GIF
int gifDelay = 100; // Delay between frames in milliseconds (adjust as needed)
float scaleFactor = 0.5f; // Scale factor for input images

void setup() {
  size(200, 200); // Set a default size (will be adjusted later)

  // Get the absolute path to the data folder
  imageFolderPath = dataPath(""); // "" refers to the data folder itself
  println("Image folder path: " + imageFolderPath);

  File folder = new File(imageFolderPath);
  if (!folder.exists() || !folder.isDirectory()) {
    println("Error: Invalid data folder path.");
    exit();
  }

  File[] imageFiles = folder.listFiles();

  // Filter out non-image files and sort by name
  Arrays.sort(imageFiles, (f1, f2) -> f1.getName().compareTo(f2.getName()));

  // Find the first image to get dimensions (for setting canvas size)
  PImage firstImage = null;
  for (File file : imageFiles) {
    if (isImageFile(file)) {
      firstImage = loadImage(file.getAbsolutePath());
      break;
    }
  }

  if (firstImage == null) {
    println("Error: No image files found in the data folder.");
    exit();
  }

  // Resize the canvas based on the scaled dimensions of the first image
  surface.setSize((int)(firstImage.width * scaleFactor), (int)(firstImage.height * scaleFactor));

  gifMaker = new GifMaker(this, outputGifPath);
  gifMaker.setDelay(gifDelay);
  gifMaker.setRepeat(0); // 0 means loop indefinitely

  // Load, scale, and add each image as a frame
  for (File file : imageFiles) {
    if (isImageFile(file)) {
      PImage img = loadImage(file.getAbsolutePath());
      if (img != null) {
        // Scale the image
        img.resize((int)(img.width * scaleFactor), (int)(img.height * scaleFactor));
        // Resize the frame to match the canvas size
        img.resize(width, height);
        gifMaker.addFrame(img);
        println("Added frame: " + file.getName());
      }
    }
  }

  gifMaker.finish();
  println("GIF created: " + outputGifPath);
}

void draw() {
  background(255);
  // Display a message (since 'images' array is not used here)
  fill(0);
  text("Creating GIF...", 10, 20);
}

// Helper function to check if a file is an image file (based on extension)
boolean isImageFile(File file) {
  String name = file.getName().toLowerCase();
  return name.endsWith(".jpg") || name.endsWith(".jpeg") || name.endsWith(".png") || name.endsWith(".gif");
}
