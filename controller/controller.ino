#include "Keyboard.h"

const int JOYSTICK_Y = A0;
const int RANGE_SENSOR = 13;

const int BUTTON_COIN = 7;

const int CAMERA_CW = 21;
const int CAMERA_CCW = 20;
const int CAMERA_PRECISE = 19;

const int LED1 = 10;
const int LED2 = 11;
const int LED3 = 12;

// Camera CW, Camera CCW, Camera Precise
bool buttonStates[3] = {false, false, false};
int joystickCoords[1] = {0};
bool isOn = false;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);

  pinMode(CAMERA_CW, INPUT);
  pinMode(CAMERA_CCW, INPUT);
  pinMode(CAMERA_PRECISE, INPUT);

  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);

  Serial.begin(9600);
  Keyboard.begin();

  digitalWrite(LED_BUILTIN, HIGH);
}

void loop() {
  buttonStates[0] = digitalRead(CAMERA_CW);
  buttonStates[1] = digitalRead(CAMERA_CCW);
  buttonStates[2] = digitalRead(CAMERA_PRECISE);

  // Get joystick coords
  joystickCoords[1] = analogRead(JOYSTICK_Y);

  // long range = calculateRangeCm();

  if (buttonStates[0]) {
    Keyboard.press(KEY_RIGHT_ARROW);
  } else {
    Keyboard.release(KEY_RIGHT_ARROW);
  }

  if (buttonStates[3]) {
    Keyboard.press(KEY_LEFT_ARROW);
  } else {
    Keyboard.release(KEY_LEFT_ARROW);
  }

  if (joystickCoords[1] > 800) {
    Keyboard.press(KEY_UP_ARROW);
  } else {
    Keyboard.release(KEY_UP_ARROW);
  }

  // Optional - Just makes input stabler
  delay(1);

  // debugPrint();
  // Serial.print("Range:");
  // Serial.println(range);
}

void debugPrint() {
  Serial.print("A:");
  Serial.print(buttonStates[0]);
  Serial.print(" B:");
  Serial.print(buttonStates[1]);
  Serial.print(" X:");
  Serial.print(buttonStates[2]);
  Serial.print(" Y:");
  Serial.print(buttonStates[3]);
  Serial.print(" START:");
  Serial.print(buttonStates[4]);
  Serial.print(" SELECT:");
  Serial.print(buttonStates[5]);
  Serial.print(" JOYSTICK:");
  Serial.print(buttonStates[6]);
  Serial.print(" X:");
  Serial.print(joystickCoords[0]);
  Serial.print(" Y:");
  Serial.println(joystickCoords[1]);
}

long calculateRangeCm() {
  pinMode(RANGE_SENSOR, OUTPUT);
  digitalWrite(RANGE_SENSOR, LOW);
  delayMicroseconds(2); // Before t_out
  digitalWrite(RANGE_SENSOR, HIGH);
  delayMicroseconds(5); // t_out
  digitalWrite(RANGE_SENSOR, LOW);

  pinMode(RANGE_SENSOR, INPUT);
  long duration = pulseIn(RANGE_SENSOR, HIGH); // t_holdoff

  // convert the time into a distance
  long inches = microsecondsToInches(duration);
  long cm = microsecondsToCentimeters(duration);

  return cm;
}

// https://docs.arduino.cc/built-in-examples/sensors/Ping
long microsecondsToInches(long microseconds) {
  // According to Parallax's datasheet for the PING))), there are 73.746
  // microseconds per inch (i.e. sound travels at 1130 feet per second).
  // This gives the distance travelled by the ping, outbound and return,
  // so we divide by 2 to get the distance of the obstacle.
  // See:
  // https://www.parallax.com/package/ping-ultrasonic-distance-sensor-downloads/
  return microseconds / 74 / 2;
}

long microsecondsToCentimeters(long microseconds) {
  // The speed of sound is 340 m/s or 29 microseconds per centimeter.
  // The ping travels out and back, so to find the distance of the object we
  // take half of the distance travelled.
  return microseconds / 29 / 2;
}