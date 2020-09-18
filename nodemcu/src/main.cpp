#include <Arduino.h>
#include <SoftwareSerial.h>
#include <FirebaseESP8266.h>
#include <ESP8266WiFi.h>
#define WIFI_SSID "y"
#define WIFI_PASSWORD "11111111"
#define FIREBASE_HOST "urinoir-test.firebaseio.com"
#define FIREBASE_AUTH "akrjljnlUeUtJqaOq0uKiABV39rKisn41rKzEHPv"
#define data_rx D1
#define data_tx D2

SoftwareSerial data(data_rx,data_tx);
FirebaseData firebaseData;
void firebaseSetup(void);

void setup(){
  Serial.begin(9600);
  data.begin(9600);
  firebaseSetup();
}
void loop(){
  if(data.available()>0){
    char read = data.read();
    Firebase.setString(firebaseData,"result",(String)read);
  }
}
void firebaseSetup()
{
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  firebaseData.setBSSLBufferSize(1024, 1024);
  firebaseData.setResponseSize(1024);
}