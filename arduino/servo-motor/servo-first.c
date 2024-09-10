/* #include <Servo.h> */
#include <math.h>
#include <stdio.h>

/* Servo shoulder; */
/* Servo elbow; */

int shoulderPin = 5;
int elbowPin = 6;

double centreX = 0;
double centreY = 10;

double l1 = 9;
double l2 = 8;

double currentTheta = 0;
double stepTheta = 5;

double A = 4;
double K = 0.5;

double xRose, yRose;

double sg; // shoulder to ground
double ag; // arm to ground
double as; // arm relative to shoulder

double radToDeg(double theta) { return theta * 180 / M_PI; }

double degToRad(double theta) { return theta * M_PI / 180; }

void setup()
{
   // put your setup code here, to run once:
   /* shoulder.attach(shoulderPin); */
   /* elbow.attach(elbowPin); */
   // initially set both to zero
   /* shoulder.write(0); */
   /* elbow.write(0); */
   /* delay(100); */
   /* Serial.begin(9600); */
}

int i = 0;

void loop()
{
   // put your main code here, to run repeatedly:

   xRose = centreX + A * cos(degToRad(K * currentTheta)) * cos(degToRad(currentTheta));
   yRose = centreY + A * cos(degToRad(K * currentTheta)) * sin(degToRad(currentTheta));

   sg = acos((xRose * xRose + yRose * yRose + l1 * l1 - l2 * l2) /
             (2 * l1 * sqrt(xRose * xRose + yRose * yRose))) +
        atan2(yRose, xRose);

   ag = atan2(yRose - l1 * sin(sg), xRose - l1 * cos(sg));

   sg = radToDeg(sg);
   ag = radToDeg(ag);

   as = ag - sg;

   /* shoulder.write(sg); */
   /* elbow.write(as); */
   /**/
   /* Serial.println(ag); */
   /* Serial.println(as); */

   currentTheta += stepTheta;

   if (currentTheta >= 720)
   {
      currentTheta = 0;
   }
   /* delay(100); */
}

int main(int argc, char *argv[])
{
   setup();

   FILE *file = fopen("test", "w");

   for (int iter = 0; iter < 150; ++iter)
   {
      loop();
      fprintf(file, "%0.2f , %0.2f, %0.2f, %0.2f\n", currentTheta, sg, ag, as);
   }


   return 0;
}
