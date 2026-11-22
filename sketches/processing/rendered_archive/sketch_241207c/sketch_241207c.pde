import com.hamoid.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;
import processing.data.JSONObject;
import processing.data.JSONArray;

VideoExport videoExport;
int fps = 120; // Frames per second
int duration = 5; // Duration in seconds
boolean recording = false;

JSONObject jsonData;
HashMap<String, Integer> dailyCounts = new HashMap<>();
int minCount = 0;
int maxCount = 0;

float zOffset = 0; // Initial z-axis offset (not used)
float zDepth = 1500; // Simulated depth (not used)

// Rotation variables (not used)
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

void setup() {
    size(1440/2*3, 1440/2*3, P2D);
    frameRate(fps);
    smooth(20);

    //noSmooth();

    innerCircleDiameter = height / 4;
    outerCircleDiameter = height;
    constantGap = (outerCircleDiameter - innerCircleDiameter) / (2 * (366 / daysPerCircle));

    sliderY = height / 2;
    sliderHandleY = sliderY;

    // Load and process JSON data
    loadAndProcessData("Tasks.json"); // Replace with your JSON file name
    mono = loadFont("Roboto-Bold-255.vlw");

    videoExport = new VideoExport(this, "myVideo.mp4");
    videoExport.setFrameRate(fps);
    // videoExport.setQuality(100); // Optional: Set quality (0-100, default 50)
}

void draw() {
    background(255);

    pushMatrix();
    translate(width / 2, height / 2);

    drawConcentricCalendar();
    drawYear();
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
    float x = 0, y = 0;
    float currentRadius = 0;
    int dayCounter = 1;
    int daysInYear = 365;
    float clockRadius = innerCircleDiameter * 0.2;
    float circleSize = clockRadius * 0.4 * 1;
    float radialGap = circleSize * 0.0002;
    float angleIncrement = radians(5);

    if (isLeapYear(year())) {
        daysInYear = 366;
    }

    int[] monthStartDays = new int[13];
    monthStartDays[1] = 1;
    for (int m = 2; m <= 12; m++) {
        monthStartDays[m] = monthStartDays[m - 1] + getDaysInMonth(m - 1, year());
    }

    float startAngle = -HALF_PI;
    float maxRadius = height / 2 - radialGap;

    // Calculate the total radial distance available for the spiral
    float totalRadialDistance = maxRadius - innerCircleDiameter - radialGap - circleSize / 2;

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

        // Calculate the proportion of the year that has passed
        float yearProportion = (float)(day - 1) / (daysInYear - 1);

        // Map the year proportion to the available radial distance
        currentRadius = innerCircleDiameter + radialGap + yearProportion * totalRadialDistance;

        x = currentRadius * cos(angle);
        y = currentRadius * sin(angle);

        pushMatrix();
        translate(x, y);

        // Get date string for count lookup (YYYY-MM-DD format)
        String dateString = year() + "-" + nf(currentMonth, 2) + "-" + nf(dayOfMonth, 2);

        // Get count for the current date, default to 0 if not found
        int count = dailyCounts.getOrDefault(dateString, 0);

        // Normalize count to alpha value (0-255)
        float alpha = map(count, minCount, maxCount, 0, 255);

        // Use normalized alpha for circle fill
        fill(231, 243, 54, alpha);
        noStroke();
        ellipse(0, 0, circleSize, circleSize);

        // Ensure text is centered within the circle
        fill(0);
        textAlign(CENTER, CENTER);
        textFont(mono);
        textSize(circleSize * 0.4);

        // Display only the day
        String dateText = nf(dayOfMonth, 2);

        text(dateText, 0, 0);

        popMatrix();
        startAngle += angleIncrement;
    }
}

void drawYear() {
    fill(0);
    textAlign(CENTER, CENTER);
    textFont(mono);
    textSize(innerCircleDiameter * 0.2);
    text(year(), 0, height * 0.07);
}

void drawAnalogClock() {
    float clockRadius = innerCircleDiameter * 0.9;
    float hourFontSize = innerCircleDiameter * 0.02;
    float minuteRingRadius = clockRadius * 0.55;
    float secondsRingRadius = clockRadius * 0.85;
    float ringLabelSize = clockRadius * 0.5/ 4;
    int numMinuteMarkers = 60; // Number of markers on the minute ring
    int numSecondMarkers = 60; // Number of markers on the seconds ring

    // Hour display (HH at the center)
    fill(0);
    textAlign(CENTER, CENTER);
    textFont(mono);
    textSize(hourFontSize * 20);
    text(nf(hour() % 12, 2), 0, 0);

    // Minute ring (rotates based on current minute)
    pushMatrix();  // Save the current transformation state
    rotate(map(minute(), 0, 60, 0, TWO_PI)); // Rotate based on minute

    for (int i = 0; i < numMinuteMarkers; i++) {
        float angle = map(i, 0, numMinuteMarkers, TWO_PI, 0);
        float x = minuteRingRadius * cos(angle);
        float y = minuteRingRadius * sin(angle);

        pushMatrix();
        translate(x, y);
        rotate(angle + HALF_PI);

        // Add minute labels at 5-minute intervals
        if (i % 5 == 0) {
            fill(0);
            textFont(mono);
            textSize(ringLabelSize * 0.8);
            textAlign(CENTER, CENTER);
            text(nf(i, 2), 0, 0);
                        // Draw minute markers
            strokeWeight(5); // Thicker markers
            stroke(0);
            line(0, -15, 0, -40); // Example marker (adjust size and position)
            
        } else {
            // Draw minute markers
            strokeWeight(10); // Thicker markers
            
            stroke(0);
            point(0, -40);//, 0, -40); // Example marker (adjust size and position)
        }
        popMatrix();
    }

    popMatrix();



    // Seconds ring (rotates based on seconds)
    pushMatrix(); // Save transformation state
    rotate(map(second(), 0, 60, 0, TWO_PI)); // Rotate based on seconds

    for (int i = 0; i < numSecondMarkers; i++) {
        float angle = map(i, 0, numSecondMarkers, TWO_PI, 0 );
        float x = secondsRingRadius * cos(angle);
        float y = secondsRingRadius * sin(angle);

        pushMatrix();
        translate(x, y);
        rotate(angle + HALF_PI); // Rotate for alignment

        // Add second labels at 5-second intervals
        if (i % 5 == 0) {
            fill(180);
            textFont(mono);

            textSize(ringLabelSize * 0.8);
            textAlign(CENTER, CENTER);
            text(nf(i, 2), 0, 0);
                        // Draw second markers
            strokeWeight(5);  // Thinner markers
            stroke(0);  // Lighter color
            line(0, 30, 0, 50); // Example marker (adjust size and position)
        } else {
            // Draw second markers
            strokeWeight(30);  // Thinner markers
            stroke(0);  // Lighter color
            point(0, 50);//, 0, 10); // Example marker (adjust size and position)
        }

        popMatrix();
    }
    popMatrix(); // Restore previous transformation state
    
        // --- Minute and Second Boxes ---
    float boxWidth = hourFontSize * 13;
    float boxHeight = hourFontSize * 13;
    float boxCornerRadius = boxHeight * 0.2;

    // Minute box
    rectMode(CENTER);
    fill(0);
    rect(minuteRingRadius, 0, boxWidth, boxHeight, boxCornerRadius); 
    fill(0, 200, 100);
    textAlign(CENTER, CENTER);
    textFont(mono);
    textSize(hourFontSize * 10);
    text(nf(minute(), 2), minuteRingRadius, 0);

    // Second box
    rectMode(CENTER);
    fill(0);
    rect(secondsRingRadius, 0, boxWidth, boxHeight, boxCornerRadius);
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    textFont(mono);
    textSize(hourFontSize * 10);
    text(nf(second(), 2), secondsRingRadius, 0);
    
    
}

boolean isLeapYear(int y) {
    if (y % 4 != 0) {
        return false;
    } else if (y % 100 != 0) {
        return true;
    } else if (y % 400 != 0) {
        return false;
    } else {
        return true;
    }
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

    // Assuming the structure you provided is consistent
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
                            String dateOnly = updatedDate.substring(0, 10); // Extract YYYY-MM-DD

                            // Increment count for the date
                            dailyCounts.put(dateOnly, dailyCounts.getOrDefault(dateOnly, 0) + 1);
                        }
                    }
                }
            }
        }
    }
    // Calculate min and max counts
    if (!dailyCounts.isEmpty()) {
        minCount = Integer.MAX_VALUE;
        maxCount = Integer.MIN_VALUE;
        for (int count : dailyCounts.values()) {
            minCount = min(minCount, count);
            maxCount = max(maxCount, count);
        }
    }
    println("min count: " + minCount + " , max count: " + maxCount);
}
