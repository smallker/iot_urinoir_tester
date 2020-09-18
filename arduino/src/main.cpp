#include <Arduino.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <SoftwareSerial.h>
#define data_rx 7
#define data_tx 8
LiquidCrystal_I2C lcd(0x27, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE); // Set the LCD I2C address
SoftwareSerial data(data_rx, data_tx);
void ISR_INTO(void);
void TCS(void);
void timer2_init(void);


int s0 = 3, s1 = 4, s2 = 5, s3 = 6;
int flag = 0;
int counter = 0;
int countR = 0, countG = 0, countB = 0;

int t1 = 3;
int t2 = 3;
int t3 = 3;
int t4 = 3;
int t5 = 4;

int R1_L = 19 - t1, R1_H = 19 + t1;
int G1_L = 8 - t1, G1_H = 8 + t1;
int B1_L = 8 - t1, B1_H = 8 + t1;

int R2_L = 21 - t2, R2_H = 21 + t2;
int G2_L = 10 - t2, G2_H = 10 + t2;
int B2_L = 9 - t2, B2_H = 9 + t2;

int R3_L = 25 - t3, R3_H = 25 + t3;
int G3_L = 15 - t3, G3_H = 15 + t3;
int B3_L = 10 - t3, B3_H = 10 + t3;

int R4_L = 25 - t4, R4_H = 25 + t4;
int G4_L = 17 - t4, G4_H = 17 + t4;
int B4_L = 13 - t4, B4_H = 13 + t4;

int R5_L = 26 - t5, R5_H = 26 + t5;
int G5_L = 22 - t5, G5_H = 22 + t5;
int B5_L = 24 - t5, B5_H = 24 + t5;

void setup()
{
  Serial.begin(115200);
  data.begin(9600);
  lcd.begin(16, 2);
  lcd.backlight();
  delay(250);
  lcd.noBacklight();
  delay(250);
  lcd.backlight();

  lcd.setCursor(0, 0);
  lcd.print("   MONITORING   ");
  delay(1000);
  lcd.setCursor(0, 1);
  lcd.print("STATUS DEHIDRASI");
  delay(1000);

  pinMode(s0, OUTPUT);
  pinMode(s1, OUTPUT);
  pinMode(s2, OUTPUT);
  pinMode(s3, OUTPUT);
}
void TCS()
{
  digitalWrite(s1, HIGH);
  digitalWrite(s0, LOW);
  flag = 0;
  attachInterrupt(0, ISR_INTO, CHANGE);
  timer2_init();
}
void ISR_INTO()
{
  counter++;
}
void timer2_init(void)
{
  TCCR2A = 0x00;
  TCCR2B = 0x07; //the clock frequency source 1024 points
  TCNT2 = 100;   //10 ms overflow again
  TIMSK2 = 0x01; //allow interrupt
}
int i = 0;
ISR(TIMER2_OVF_vect) //the timer 2, 10ms interrupt overflow again. Internal overflow interrupt executive function
{
  TCNT2 = 100;
  flag++;
  if (flag == 1)
  {
    counter = 0;
  }
  else if (flag == 2)
  {
    digitalWrite(s2, LOW);
    digitalWrite(s3, LOW);
    countR = counter / 1.051;
    Serial.print("red=");
    Serial.println(countR, DEC);
    digitalWrite(s2, HIGH);
    digitalWrite(s3, HIGH);
  }
  else if (flag == 3)
  {
    countG = counter / 1.0157;
    Serial.print("green=");
    Serial.println(countG, DEC);
    digitalWrite(s2, LOW);
    digitalWrite(s3, HIGH);
  }
  else if (flag == 4)
  {
    countB = counter / 1.114;
    Serial.print("blue=");
    Serial.println(countB, DEC);
    digitalWrite(s2, LOW);
    digitalWrite(s3, LOW);
  }
  else
  {
    flag = 0;
    TIMSK2 = 0x00;
  }
  counter = 0;
  delay(2);
}
void loop()
{
  delay(10);
  TCS();

  /*
  lcd.setCursor(0,0);
  lcd.print("R=");
  lcd.print(countR);
  
  lcd.print(" G=");
  lcd.print(countG);

  lcd.print(" B=");
  lcd.print(countB);
*/

  if ((countR > R1_L && countR < R1_H) && (countG > G1_L && countG < G1_H) && (countB > B1_L && countB < B1_H))
  {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("STATUS DEHIDRASI");

    lcd.setCursor(0, 1);
    lcd.print(" SANGAT  BERAT  ");
    data.write("4");
    delay(1000);
  }
  else if ((countR >= R2_L && countR <= R2_H) && (countG >= G2_L && countG <= G2_H) && (countB >= B2_L && countB <= B2_H))
  {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("STATUS DEHIDRASI");

    lcd.setCursor(0, 1);
    lcd.print("      BERAT     ");
    data.write("3");
    delay(1000);
  }
  else if ((countR >= R3_L && countR <= R3_H) && (countG >= G3_L && countG <= G3_H) && (countB >= B3_L && countB <= B3_H))
  {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("STATUS DEHIDRASI");

    lcd.setCursor(0, 1);
    lcd.print("    Dehidrasi   ");

    data.write("2");
    delay(1000);
  }
  else if ((countR >= R4_L && countR <= R4_H) && (countG >= G4_L && countG <= G4_H) && (countB >= B4_L && countB <= B4_H))
  {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("STATUS DEHIDRASI");

    lcd.setCursor(0, 1);
    lcd.print("     RINGAN     ");

    data.write("1");
    delay(1000);
  }
  else if ((countR >= R5_L && countR <= R5_H) && (countG >= G5_L && countG <= G5_H) && (countB >= B5_L && countB <= B5_H))
  {
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("STATUS DEHIDRASI");

    lcd.setCursor(0, 1);
    lcd.print("      AMAN      ");

    data.write("0");
    delay(1000);
  }
  else
  {
    lcd.setCursor(0, 0);
    lcd.print("   MONITORING   ");
    lcd.setCursor(0, 1);
    lcd.print("STATUS DEHIDRASI");
    delay(1000);
  }
}