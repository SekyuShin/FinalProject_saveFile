#include<Wire.h>


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial3.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial3.available()) {
    Serial.write(Serial3.read());
  }
  if(Serial.available()) {
    Serial3.write(Serial.read());
  }


}
