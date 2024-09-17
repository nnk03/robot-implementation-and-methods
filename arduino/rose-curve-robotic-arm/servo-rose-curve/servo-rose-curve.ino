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
const float centreX = 0.0;
const float centreY = 10.0;
const int numSteps = 1000;

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
   /*
   x and y are the desired points on rose curve

   x = l1 cos theta1 + l2 cos theta2
   y = l1 sin theta1 + l2 sin theta2

   psi = theta2 - theta1

   x^2 + y^2 = l1^2 + l2^2 + 2 l1 l2 (cos (theta2 - theta1))

   psi is the angle of arm relative to shoulder
   and
   theta1 is the angle of shoulder relative to ground
    */

   for (int i = 0; i < numSteps; i++)
   {
      float t = (16 * PI * i) / numSteps;

      float x = centreX + radius * cos(k * t) * cos(t);
      float y = centreY + radius * cos(k * t) * sin(t);

      float d = (x * x + y * y - L1 * L1 - L2 * L2) / (2 * L1 * L2);
      float psi = acos(d);
      float theta1 = atan2(y, x) - atan2(L2 * sin(psi), L1 + L2 * cos(psi));

      float shoulderAngle = degrees(theta1); // theta1 is in radians
      float elbowAngle = degrees(psi);       // psi is in radians

      shoulderServo.write(shoulderAngle);
      elbowServo.write(elbowAngle);

      delay(50);
   }
}
