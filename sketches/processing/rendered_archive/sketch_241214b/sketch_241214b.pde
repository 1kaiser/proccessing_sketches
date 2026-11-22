import com.hamoid.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;
import processing.data.JSONObject;
import processing.data.JSONArray;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.time.Month;
import java.time.LocalDate;
import java.util.Collections;


VideoExport videoExport;
int fps = 120;        // Frames per second
int duration = 5;     // Duration in seconds
boolean recording = false;

JSONObject jsonData;
HashMap<String, Integer> dailyCounts = new HashMap<>();
int minCount = 0;
int maxCount = 0;

float zOffset = 0;    // Initial z-axis offset (not used)
float zDepth = 2000;  // Simulated depth (not used)

// Rotation variables
float rotY = 0;
float prevMouseX = 0;

float innerCircleDiameter;
float outerCircleDiameter;
float constantGap;
float daysPerCircle = 60;

float sliderY;
float sliderHeight = 100;
float sliderWidth = 20;
float sliderHandleY;
float sliderHandleHeight = 10;
boolean sliderPressed = false;

PFont mono;
PShape star;
List<PShape> svgShapes = new ArrayList<>();  // List to store SVG shapes

// Data structure to store fixed SVG positions for each date
HashMap<String, ArrayList<PVector>> svgPositions = new HashMap<>();
HashMap<String, ArrayList<Integer>> svgIndices = new HashMap<>();
ArrayList<String> datesWithSVGs = new ArrayList<>(); // List to store dates that have SVGs

Random rand = new Random();

void setup() {
  size(1440/2*3, 1440/2*3, P3D);
  //size(1440, 1440, P3D);

  frameRate(fps);
  smooth(20);

  innerCircleDiameter = height / 4;
  outerCircleDiameter = height;
  constantGap = (outerCircleDiameter - innerCircleDiameter) / (2 * (366 / daysPerCircle));

  sliderY = height / 2;
  sliderHandleY = sliderY;

  // Load and process JSON data
  loadAndProcessData("Tasks.json"); // Replace with your JSON file name
  mono = loadFont("Roboto-Bold-255.vlw");
  star = loadShape("snow.svg"); // Or createShape() if you want to generate it programmatically
  String[] svgFilenames = {
    "cherry.svg",
    //"chines_knot.svg",
    //"chocolate.svg",
    "christmas_ball.svg",
    "gift.svg",
    "hawthorn.svg",
    "lollipop.svg",
    "lollipop_.svg",
    //"love.svg",
    //"snow.svg",
    "socks.svg",
    "socks_.svg",
    "staff.svg",
    // ... add more filenames
  };

  List<String> filenamesList = Arrays.asList(svgFilenames);

  // Load SVG files from the list
  for (String filename : filenamesList) {
    // Construct the full path
    String fullPath = dataPath(filename); // Combines data path with filename
    svgShapes.add(loadShape(fullPath));

    if (svgShapes.get(svgShapes.size() - 1) == null) {
      println("Error loading SVG: " + filename);
      svgShapes.remove(svgShapes.size() - 1); // Remove null element
    }
  }

  videoExport = new VideoExport(this, "myVideo.mp4");
  videoExport.setFrameRate(fps);
  // videoExport.setQuality(100); // Optional: Set quality (0-100, default 50)
}

void draw() {
  // Define spotlight position (above the center)
  float spotlightX = width / 2;
  float spotlightY = -500; // Adjust this value to control the height of the spotlight
  float spotlightZ = 0;

  // Define spotlight target (center of the scene)
  float targetX = width / 2;
  float targetY = height / 2;
  float targetZ = 0;

  // Spotlight color (white light)
  color lightColor = color(255, 255, 255);

  // Spotlight intensity (0.0 to 1.0)
  float lightIntensity = 0.8;

  // Spotlight cone angle (in radians, smaller angle = tighter cone)
  float coneAngle = PI / 6; // Adjust for wider/narrower spotlight

  // Spotlight exponent (controls the sharpness of the spotlight edge)
  float coneExponent = 20; // Higher value = sharper edge

  // Apply the spotlight
  //spotLight(
  //  red(lightColor) * lightIntensity,   // Red component of light
  //  green(lightColor) * lightIntensity, // Green component
  //  blue(lightColor) * lightIntensity,  // Blue component
  //  spotlightX, spotlightY, spotlightZ, // Spotlight position
  //  targetX - spotlightX, targetY - spotlightY, targetZ - spotlightZ, // Spotlight direction (normalized)
  //  coneAngle, // Cone angle
  //  coneExponent // Cone exponent
  //);
  background(255);
  // Add ambient light
  //ambientLight(50, 50, 50);

  // Set up the camera and perspective
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, (float)width/(float)height, cameraZ/10.0, cameraZ*10.0);

  pushMatrix();
  translate(width / 2, height/2+350, -500);
  rotateX(map(frameCount, 0, 120*5,-PI/4,0)); // Rotate the view for side view
  rotateY(-frameCount * 0.01);  // Auto-rotate

  // Mouse-controlled rotation (optional)
  if (mousePressed) {
    rotY += (mouseX - prevMouseX) * 0.01;
  }
  prevMouseX = mouseX;
  rotateY(rotY);

  drawConcentricCalendar();

  drawAnalogClock();

  popMatrix();

  if (recording) {
    videoExport.saveFrame();
    // Draw a red recording indicator
    fill(255, 0, 0);
    noStroke();
    ellipse(width - 30, 30, 20, 20);
  }

  // Start recording on first frame
  if (frameCount == 1) {
    videoExport.startMovie();
    recording = true;
  }

  // Stop recording after specified duration
  if (recording && frameCount >= fps * duration) {
    videoExport.endMovie();
    recording = false;
    println("Video saved!");
    exit(); // Stop the sketch (optional)
  }
}

void drawConcentricCalendar() {
  float angle = 0;
  float x = 0, y = 0, z = 0;
  float currentRadius = 0;
  int daysInYear = 365;
  float clockRadius = innerCircleDiameter * 0.2;
  float circleSize = clockRadius * 0.4 * 1;
  float radialGap = circleSize * 0.0002;
  float angleIncrement = radians(5); // Controls spiral spacing
  float baseWidth = width / 1.5;

  if (isLeapYear(year())) {
    daysInYear = 366;
  }

  int[] monthStartDays = new int[13];
  monthStartDays[1] = 1;
  for (int m = 2; m <= 12; m++) {
    monthStartDays[m] = monthStartDays[m - 1] + getDaysInMonth(m - 1, year());
  }

  float startAngle = -HALF_PI;
  float maxRadius = baseWidth / 2;

  float totalRadialDistance = maxRadius - radialGap - circleSize / 2;

  for (int day = 1; day <= daysInYear; day++) {
    int currentMonth = 0;
    for (int m = 1; m <= 12; m++) {
      if (day >= monthStartDays[m] && day < monthStartDays[m] + getDaysInMonth(m, year())) {
        currentMonth = m;
        break;
      }
    }

    int dayOfMonth = day - monthStartDays[currentMonth] + 1;

    angle = startAngle;

    float yearProportion = (float) (day - 1) / (daysInYear - 1);

    currentRadius = maxRadius * (1 - yearProportion);

    x = currentRadius * cos(angle);
    z = currentRadius * sin(angle);

    float heightMultiplier = 0.70f;
    float verticalOffset = height * 0.10f;

    y = -yearProportion * height * heightMultiplier + verticalOffset;

    pushMatrix();
    translate(x, y, z);

    String dateString = year() + "-" + nf(currentMonth, 2) + "-" + nf(dayOfMonth, 2);

    int count = dailyCounts.getOrDefault(dateString, 0);

    float alpha = map(count, minCount -1, maxCount, 10, 200);
    float regulator = map(currentRadius, 0, maxRadius, 0.1, 1);

    fill(231, 243, 54, alpha);
    noStroke();

    //sphere(circleSize/ 2 * regulator);

    // --- SVG Placement Logic ---
    if (datesWithSVGs.contains(dateString)) {
      // Date has SVGs
      if (!svgPositions.containsKey(dateString)) {
        // First time seeing this date with SVGs, generate random positions and SVG indices
        ArrayList<PVector> positions = new ArrayList<>();
        ArrayList<Integer> indices = new ArrayList<>();
        //int numSvgs = (int) random(1, 4); // Place 1 to 3 SVGs randomly
        int numSvgs = 1; // Place 1 to 3 SVGs randomly

        for (int i = 0; i < numSvgs; i++) {
          float offsetX = random(-circleSize * 0.7f, circleSize * 0.7f);
          float offsetZ = random(-circleSize * 0.7f, circleSize * 0.7f);
          positions.add(new PVector(offsetX, offsetZ)); // Store relative offsets

          int svgIndex = (int) random(svgShapes.size());
          indices.add(svgIndex);
        }

        svgPositions.put(dateString, positions);
        svgIndices.put(dateString, indices);
      }

      // Retrieve and use the fixed SVG positions and indices
      ArrayList<PVector> positions = svgPositions.get(dateString);
      ArrayList<Integer> indices = svgIndices.get(dateString);

      for (int i = 0; i < positions.size(); i++) {
        PVector offset = positions.get(i);
        int svgIndex = indices.get(i);
        PShape currentShape = svgShapes.get(svgIndex);

        pushMatrix();
        PVector projectedPoint = new PVector(x, 0, z); 
        PVector direction = PVector.sub(projectedPoint, new PVector(0, 0, 0));
        float angleToGravityPlane = PVector.angleBetween(new PVector(0, -1, 0), direction);
        PVector axis = new PVector(0, -1, 0).cross(direction);
        rotate(angleToGravityPlane, axis.x, axis.y, axis.z);
        rotateY(-atan2(z, x));
        rotateX(PI/2);
        rotateZ(-PI/2);
        scale(0.2 );
        shape(currentShape, -currentShape.getWidth() / 2, -currentShape.getHeight() / 2);
        popMatrix();
      }
    }

    // Text Drawing (Billboarded)
    pushMatrix();
    PVector projectedPoint = new PVector(x, 0, z); 
    PVector direction = PVector.sub(projectedPoint, new PVector(0, 0, 0));
    float angleToGravityPlane = PVector.angleBetween(new PVector(0, -1, 0), direction);
    PVector axis = new PVector(0, -1, 0).cross(direction);
    rotate(angleToGravityPlane, axis.x, axis.y, axis.z);
    rotateY(-atan2(z, x));
    rotateX(PI/2);
    rotateZ(-PI/2);
    fill(20, 200, 100, 150);
    textAlign(CENTER, CENTER);
    textFont(mono);
    textSize(circleSize / 1.5 * regulator);
    translate(0, 0, 0);
    text(nf(dayOfMonth, 2), 0, 0);
    popMatrix();

    popMatrix();
    startAngle += angleIncrement;
  }

  // Draw the star at the top (after the loop)
  pushMatrix();
  translate(0, 0, 0);
  scale(0.2);
  shape(star, -star.getWidth() / 2 - circleSize, -3 * height - star.getHeight() - circleSize);
  popMatrix();
}

void drawAnalogClock() {
  float clockRadius = innerCircleDiameter * 1;
  float hourFontSize = innerCircleDiameter * 0.02;
  float minuteRingRadius = clockRadius * 0.55;
  float secondsRingRadius = clockRadius * 0.85;
  float ringLabelSize = clockRadius * 0.5 / 4;
  int numMinuteMarkers = 60; // Number of markers on the minute ring
  int numSecondMarkers = 60; // Number of markers on the seconds ring

  pushMatrix(); // Isolate clock transformations

  // Position the clock at the base of the spiral
  translate(0, -height * 0.60f * 0 + height * 0.10f, 0); // Match y offset from drawConcentricCalendar()
  rotateX(PI / 2); // Rotate to align with the base
  rotateZ(rotY);

  // Hour display (HH at the center)
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(mono);
  textSize(hourFontSize * 20);
  text(nf(hour() % 12, 2), 0, 0, 0); // Position in 3D
  rotateX(-PI / 2); // Rotate to align with the base

  // Minute ring (rotates based on current minute)
  pushMatrix();
  rotateX(PI / 2); // Rotate to align with the base
  rotate(map(minute(), 0, 60, 0, TWO_PI)); // Rotate based on minute

  for (int i = 0; i < numMinuteMarkers; i++) {
    float angle = map(i, 0, numMinuteMarkers, TWO_PI, 0);
    float x = minuteRingRadius * cos(angle);
    float y = minuteRingRadius * sin(angle);

    pushMatrix();
    translate(x, y, 0);
    rotate(angle + HALF_PI);

    // Minute markers and labels
    if (i % 5 == 0) {
      fill(0);
      textFont(mono);
      textSize(ringLabelSize * 0.8);
      textAlign(CENTER, CENTER);
      text(nf(i, 2), 0, 0);

      strokeWeight(5);
      stroke(0);
      line(0, -15, 0, -40);
    } else {
      noStroke();
      fill(0);
      circle(0, -40, 10);
    }

    popMatrix();
  }

  popMatrix(); // Restore minute ring rotation

  // Seconds ring (rotates based on seconds)
  pushMatrix();
  rotateX(PI / 2); // Rotate to align with the base
  rotate(map(second(), 0, 60, 0, TWO_PI)); // Rotate based on seconds

  for (int i = 0; i < numSecondMarkers; i++) {
    float angle = map(i, 0, numSecondMarkers, TWO_PI, 0);
    float x = secondsRingRadius * cos(angle);
    float y = secondsRingRadius * sin(angle);

    pushMatrix();
    translate(x, y, 0);
    rotate(angle + HALF_PI);

    // Second labels and markers
    if (i % 5 == 0) {
      fill(180);
      textFont(mono);
      textSize(ringLabelSize * 0.8);
      textAlign(CENTER, CENTER);
      text(nf(i, 2), 0, 0);

      strokeWeight(5);
      stroke(0);
      line(0, 30, 0, 50);
    } else {
      noStroke();
      fill(0);
      circle(0, 50, 20);
    }

    popMatrix();
  }

  popMatrix(); // Restore seconds ring rotation

  // --- Minute and Second Boxes ---
  float boxWidth = hourFontSize * 13;
  float boxHeight = hourFontSize * 13;
  float boxCornerRadius = boxHeight * 0.2;

  // Minute box
  pushMatrix();
  translate(minuteRingRadius, 0, 0);
  rotateX(PI/2 );

  rectMode(CENTER);
  fill(0);
  strokeWeight(5);
  rect(0, 0, boxWidth, boxHeight, boxCornerRadius);
  fill(0, 200, 100);
  textAlign(CENTER, CENTER);
  textFont(mono);
  textSize(hourFontSize * 10);
  text(nf(minute(), 2), 0, 0);
  popMatrix();

  // Second box
  pushMatrix();
  translate(secondsRingRadius, 0, 0);
  rotateX(PI/2 );
  rectMode(CENTER);
  fill(0);
  strokeWeight(5);
  rect(0, 0, boxWidth, boxHeight, boxCornerRadius);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  textFont(mono);
  textSize(hourFontSize * 10);
  text(nf(second(), 2), 0, 0);
  popMatrix();

  popMatrix();  // Restore clock transformations
}

boolean isLeapYear(int y) {
  return (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0);
}

int getDaysInMonth(int m, int y) {
  if (m == 2) {
    return isLeapYear(y) ? 29 : 28;
  } else if (m == 4 || m == 6 || m == 9 || m == 11) {
    return 30;
  } else {
    return 31;
  }
}

void loadAndProcessData(String filename) {
  jsonData = loadJSONObject(filename);

  if (jsonData == null) {
    println("Error: Could not load JSON file or file is empty.");
    return;
  }

  JSONArray items = jsonData.getJSONArray("items");
  if (items != null) {
    for (int i = 0; i < items.size(); i++) {
      JSONObject item = items.getJSONObject(i);
      if (item.hasKey("items")) {
        JSONArray subItems = item.getJSONArray("items");
        for (int j = 0; j < subItems.size(); j++) {
          JSONObject subItem = subItems.getJSONObject(j);
          if (subItem.hasKey("title") && subItem.getString("title").toLowerCase().contains("#s")) {
            if (subItem.hasKey("updated")) {
              String updatedDate = subItem.getString("updated");
              String dateOnly = updatedDate.substring(0, 10);

              dailyCounts.put(dateOnly, dailyCounts.getOrDefault(dateOnly, 0) + 1);
            }
          }
        }
      }
    }
  }

  if (!dailyCounts.isEmpty()) {
    minCount = Integer.MAX_VALUE;
    maxCount = Integer.MIN_VALUE;
    for (int count : dailyCounts.values()) {
      minCount = min(minCount, count);
      maxCount = max(maxCount, count);
    }

    // Select 10 random dates with the highest daily counts to place SVGs
    ArrayList<Map.Entry<String, Integer>> sortedEntries = new ArrayList<>(dailyCounts.entrySet());
    sortedEntries.sort((entry1, entry2) -> entry2.getValue().compareTo(entry1.getValue())); // Sort descending by count

    int numDatesToSelect = min(70, sortedEntries.size()); // Select up to 10 dates

    for (int i = 0; i < numDatesToSelect; i++) {
      datesWithSVGs.add(sortedEntries.get(i).getKey());
    }
  }

  println("min count: " + minCount + " , max count: " + maxCount);
  println("Dates with SVGs: " + datesWithSVGs);
}
