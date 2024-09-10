#include <Servo.h>
#include <math.h>

Servo shoulder, elbow;

int shoulderPin = 5;
int elbowPin = 6;

void setup()
{
   // put your setup code here, to run once:
   shoulder.attach(shoulderPin);
   elbow.attach(elbowPin);
   shoulder.write(0);
   elbow.write(0);
   delay(100);
}

void loop()
{
   // put your main code here, to run repeatedly:
   shoulder.write(0);
   elbow.write(0);
   delay(50);
}
