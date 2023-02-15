#include "Gamepad.h"

const int JOYSTICK_X = A1;
const int JOYSTICK_Y = A0;
const int BUTTON_JOYSTICK = 1;

const int BUTTON_A = 6;
const int BUTTON_B = 5;
const int BUTTON_X = 4;
const int BUTTON_Y = 3;

const int BUTTON_START = 7;
const int BUTTON_SELECT = 8;

const int LED1 = 10;
const int LED2 = 11;
const int LED3 = 12;

Gamepad mpg(GAMEPAD_DEBOUNCE_MILLIS);

// A, B, X, Y, START, SELECT, JOYSTICK
bool buttonStates[7] = {false, false, false, false, false, false, false};
int joystickCoords[2] = {0, 0};

void setup() {
  Serial.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);

  pinMode(BUTTON_A, INPUT);
  pinMode(BUTTON_B, INPUT);
  pinMode(BUTTON_X, INPUT);
  pinMode(BUTTON_Y, INPUT);

  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);

  digitalWrite(LED_BUILTIN, HIGH);
}

void loop() {
  // Get button state
  buttonStates[0] = digitalRead(BUTTON_A);
  buttonStates[1] = digitalRead(BUTTON_B);
  buttonStates[2] = digitalRead(BUTTON_X);
  buttonStates[3] = digitalRead(BUTTON_Y);
  buttonStates[4] = digitalRead(BUTTON_START);
  buttonStates[5] = digitalRead(BUTTON_SELECT);
  buttonStates[6] = digitalRead(BUTTON_JOYSTICK);

  // Get joystick coords
  joystickCoords[0] = analogRead(JOYSTICK_X);
  joystickCoords[1] = analogRead(JOYSTICK_Y);

  Serial.print("X:");
  Serial.print(joystickCoords[0]);
  Serial.print(",");
  Serial.print("Y:");
  Serial.println(joystickCoords[1]);
}