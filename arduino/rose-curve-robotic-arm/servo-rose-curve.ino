#include <Servo.h>

Servo shoulderServo;
Servo elbowServo;

const int shoulderPin = 5;
const int elbowPin = 6;

const float L1 = 9.0;
const float L2 = 8.0;

// Rose curve parameters
// r = A cos( k * theta )
const float radius = 3.0;
const float k = 0.5;
const float centerX = 0.0;
const float centerY = 10.0;
const int numSteps = 200;

void setup()
{
   shoulderServo.attach(shoulderPin);
   elbowServo.attach(elbowPin);
}

void loop()
{
   // start drawing rose curve
   drawRoseCurve(radius, k, centreX, centreY, numSteps);
}

void drawRoseCurve(float radius, float k, float centreX, float centreY, int numSteps)
{
   for (int i = 0; i < numSteps; i++)
   {
      float t = (4.0 * PI * i) / numSteps;

      float x = centerX + radius * cos(k * t) * cos(t);
      float y = centerY + radius * cos(k * t) * sin(t);

      float d = (x * x + y * y - L1 * L1 - L2 * L2) / (2 * L1 * L2);
      float theta2 = acos(d);
      float theta1 = atan2(y, x) - atan2(L2 * sin(theta2), L1 + L2 * cos(theta2));

      float shoulderAngle = degrees(theta1);
      float elbowAngle = degrees(theta2);

      shoulderServo.write(shoulderAngle + 0);
      elbowServo.write(elbowAngle);

      delay(50);
   }
}
