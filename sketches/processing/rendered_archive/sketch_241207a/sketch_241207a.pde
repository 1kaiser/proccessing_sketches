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

void setup() {
  size(1440 , 1440, P2D);
  noSmooth();

  innerCircleDiameter = height / 4;
  outerCircleDiameter = height;
  constantGap = (outerCircleDiameter - innerCircleDiameter) / (2 * (366 / daysPerCircle));

  sliderY = height / 2;
  sliderHandleY = sliderY;
}

void draw() {
  background(255);

  pushMatrix();
  translate(width / 2, height / 2);

  drawConcentricCalendar();
  drawYear();
  drawAnalogClock();
  drawSecondsHand();

  popMatrix();

  drawSlider();
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
  float totalRadialDistance = maxRadius - innerCircleDiameter  - radialGap - circleSize / 2;

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

    // Transparent grey fill, no stroke
    fill(128, 128, 128, 100); 
    noStroke();
    ellipse(0, 0, circleSize, circleSize);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(circleSize * 0.4); // Increased text size

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
  textSize(innerCircleDiameter * 0.2);
  text(year(), 0, 0);
}

void drawAnalogClock() {
  float clockRadius = innerCircleDiameter * 1;

  // Hour hand
  float hourAngle = map(hour() % 12 + minute() / 60.0, 0, 12, 0, TWO_PI) - HALF_PI;
  float hourHandLength = clockRadius * 0.5;
  strokeWeight(3);
  stroke(0);
  line(0, 0, hourHandLength * cos(hourAngle), hourHandLength * sin(hourAngle));

  // Minute hand
  float minuteAngle = map(minute(), 0, 60, 0, TWO_PI) - HALF_PI;
  float minuteHandLength = clockRadius * 0.7;
  strokeWeight(2);
  line(0, 0, minuteHandLength * cos(minuteAngle), minuteHandLength * sin(minuteAngle));

  // Hour markings
  for (int i = 0; i < 12; i++) {
    float angle = map(i, 0, 12, 0, TWO_PI) - HALF_PI;
    float x = clockRadius * 0.8 * cos(angle);
    float y = clockRadius * 0.8 * sin(angle);

    pushMatrix();
    translate(x, y);
    rotate(angle + HALF_PI);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(clockRadius * 0.15);
    text(i == 0 ? "12" : str(i), 0, 0);

    popMatrix();
  }

  // Minute markings
  for (int i = 0; i < 60; i++) {
    if (i % 5 != 0) {
      float angle = map(i, 0, 60, 0, TWO_PI) - HALF_PI;
      float x = clockRadius * 0.8 * cos(angle);
      float y = clockRadius * 0.8 * sin(angle);

      pushMatrix();
      translate(x, y);

      strokeWeight(1);
      point(0, 0);

      popMatrix();
    }
  }
}

void drawSecondsHand() {
  float clockRadius = innerCircleDiameter * 0.3;
  float secondsRadius = clockRadius * 0.9;
  float secondsAngle = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float x = secondsRadius * cos(secondsAngle);
  float y = secondsRadius * sin(secondsAngle);

  fill(255, 0, 0);
  noStroke();
  ellipse(x, y, 10, 10);
}

void drawSlider() {
  stroke(0);
  strokeWeight(2);
  line(width - sliderWidth, sliderY - sliderHeight / 2, width - sliderWidth, sliderY + sliderHeight / 2);

  if (sliderPressed) {
    fill(150);
  } else {
    fill(200);
  }
  noStroke();
  rectMode(CENTER);
  rect(width - sliderWidth, sliderHandleY, sliderWidth, sliderHandleHeight);
}

void mousePressed() {
  if (mouseX > width - sliderWidth - sliderWidth / 2 && mouseX < width - sliderWidth + sliderWidth / 2 &&
      mouseY > sliderHandleY - sliderHandleHeight / 2 && mouseY < sliderHandleY + sliderHandleHeight / 2) {
    sliderPressed = true;
  }
  prevMouseX = mouseX;
}

void mouseDragged() {
  if (sliderPressed) {
    sliderHandleY = constrain(mouseY, sliderY - sliderHeight / 2 + sliderHandleHeight / 2, sliderY + sliderHeight / 2 - sliderHandleHeight / 2);
  }
  prevMouseX = mouseX;
}

void mouseReleased() {
  sliderPressed = false;
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
