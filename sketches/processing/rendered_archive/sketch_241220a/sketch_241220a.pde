import java.io.File;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import gifAnimation.*;

GifMaker gifMaker;
String imageFolderPath; // Path to the folder containing images
String outputGifPath = "output.gif";
int gifDelay = 100;
float scaleFactor = 0.16f;

// Map to store frame numbers and their corresponding positions
HashMap<Integer, Integer> framePositions = new HashMap<Integer, Integer>() {{
  put(100, 1);
  put(1000000, 2);
  put(10000000, 3);
  put(50000000, 4);
  put(112000000, 5);
}};

void setup() {
  imageFolderPath = dataPath("");
  println("Image folder path: " + imageFolderPath);

  File folder = new File(imageFolderPath);
  if (!folder.exists() || !folder.isDirectory()) {
    println("Error: Invalid data folder path.");
    exit();
  }

  File[] imageFiles = folder.listFiles();

  // Filter out non-image files
  imageFiles = Arrays.stream(imageFiles)
                     .filter(f -> isImageFile(f))
                     .toArray(File[]::new);

  // Group files into sets based on the timestamp part of the filename
  HashMap<String, List<File>> fileSets = groupFilesByTimestamp(imageFiles);

  // Prepare the final list of files for the GIF, filling in missing images
  List<File> gifFiles = prepareGifFiles(fileSets);

  // Determine frame dimensions from the first image
  if (gifFiles.isEmpty()) {
    println("Error: No image files found for GIF.");
    exit();
  }
  PImage firstImage = loadImage(gifFiles.get(0).getAbsolutePath());
  if (firstImage == null) {
    println("Error: Could not load the first image.");
    exit();
  }
  int frameWidth = (int)(firstImage.width * scaleFactor);
  int frameHeight = (int)(firstImage.height * scaleFactor);

  // Set canvas size
  surface.setSize(frameWidth * 2, frameHeight * 4);

  gifMaker = new GifMaker(this, outputGifPath);
  gifMaker.setDelay(gifDelay);
  gifMaker.setRepeat(0);

  // Create and add frames to the GIF
  for (int i = 0; i < gifFiles.size(); i += 5) {
    List<File> frameGroup = gifFiles.subList(i, Math.min(i + 5, gifFiles.size()));
    PImage combinedFrame = createCombinedFrame(frameGroup, frameWidth, frameHeight);
    gifMaker.addFrame(combinedFrame);
    println("Added combined frame to GIF");
  }

  gifMaker.finish();
  println("GIF created: " + outputGifPath);
}

void draw() {
  background(255);
  fill(0);
  text("Creating GIF...", 10, 20);
}

boolean isImageFile(File file) {
  String name = file.getName().toLowerCase();
  return name.endsWith(".jpg") || name.endsWith(".jpeg") || name.endsWith(".png") || name.endsWith(".gif");
}

int extractNumber(String name) {
  int startIndex = name.indexOf("_s_") + 3;
  int endIndex = name.indexOf("_g_", startIndex);
  if (startIndex >= 0 && endIndex > startIndex) {
    String numberStr = name.substring(startIndex, endIndex);
    try {
      return Integer.parseInt(numberStr);
    } catch (NumberFormatException e) {
      println("Error parsing number in filename: " + name);
      return 0;
    }
  } else {
    println("Error finding _s_ or _g_ in filename: " + name);
    return 0;
  }
}

HashMap<String, List<File>> groupFilesByTimestamp(File[] files) {
  HashMap<String, List<File>> sets = new HashMap<>();
  for (File file : files) {
    String name = file.getName();
    String timestamp = name.substring(0, name.indexOf("_s_"));
    sets.computeIfAbsent(timestamp, k -> new ArrayList<>()).add(file);
  }
  return sets;
}

List<File> prepareGifFiles(HashMap<String, List<File>> fileSets) {
  List<File> gifFiles = new ArrayList<>();
  File[] lastImages = new File[6]; // Keep track of the last image for each position

  // Sort timestamps to process sets in chronological order
  List<String> timestamps = new ArrayList<>(fileSets.keySet());
  timestamps.sort(Comparator.naturalOrder());

  for (String timestamp : timestamps) {
    List<File> fileSet = fileSets.get(timestamp);
    File[] currentImages = new File[6];

    // Assign files to positions based on frame number
    for (File file : fileSet) {
      int frameNumber = extractNumber(file.getName());
      int position = framePositions.getOrDefault(frameNumber, 0);
      if (position >= 1 && position <= 5) {
        currentImages[position] = file;
        lastImages[position] = file; // Update lastImages
      }
    }

    // Fill in missing images from the last set
    for (int i = 1; i <= 5; i++) {
      if (currentImages[i] == null) {
        currentImages[i] = lastImages[i];
      }
    }

    // Add files to the final list in the order of their positions
    for (int i = 1; i <= 5; i++) {
      if (currentImages[i] != null) {
        gifFiles.add(currentImages[i]);
      }
    }
  }
  return gifFiles;
}

PImage createCombinedFrame(List<File> frameGroup, int frameWidth, int frameHeight) {
  PImage combined = createImage(width, height, ARGB);
  combined.loadPixels();

  for (int i = 0; i < frameGroup.size(); i++) {
    File file = frameGroup.get(i);
    PImage img = loadImage(file.getAbsolutePath());

    if (img == null) {
      println("Error loading image: " + file.getName());
      continue;
    }

    img.resize(frameWidth, frameHeight);

    int x = 0;
    int y = 0;

    switch (i) {
      case 0: // Top-left
        x = 0;
        y = 0;
        break;
      case 1: // Top-right
        x = frameWidth;
        y = 0;
        break;
      case 2: // Bottom-left
        x = 0;
        y = frameHeight;
        break;
      case 3: // Bottom-right
        x = frameWidth;
        y = frameHeight;
        break;
      case 4: // Extended Bottom-center
        img.resize(frameWidth * 2, frameHeight * 2); // Resize for position 5
        x = 0;
        y = frameHeight * 2;
        break;
    }

    // Copy pixels to the combined image
    for (int px = 0; px < img.width; px++) {
      for (int py = 0; py < img.height; py++) {
        int combinedIndex = (y + py) * width + (x + px);
        int frameIndex = py * img.width + px;
        if (combinedIndex >= 0 && combinedIndex < combined.pixels.length && frameIndex >= 0 && frameIndex < img.pixels.length) {
          combined.pixels[combinedIndex] = img.pixels[frameIndex];
        }
      }
    }
  }

  combined.updatePixels();
  return combined;
}
