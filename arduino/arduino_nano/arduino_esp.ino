#include <ArduinoJson.h>
#include <SoftwareSerial.h>


#define LAMP 5
char inData = "";

void setup() {
Serial.begin(9600);
pinMode(LAMP, OUTPUT);
}

void loop() {

while(Serial.available()) {
    StaticJsonDocument<300> doc;
    DeserializationError err = deserializeJson(doc, Serial);
     if (err) {
     Serial.flush();
    return;
  }
if(doc["ventilador"]){
   digitalWrite(LAMP, HIGH);
}else{
    digitalWrite(LAMP, LOW);
}
 Serial.flush();
} 

}
