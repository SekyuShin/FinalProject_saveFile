
#include <Wire.h>
#include <ESP8266WiFi.h>
#include <SoftwareSerial.h>

#ifndef STASSID
//#define STASSID "WIFI_SHIN"
//#define STAPSK  "s7221191"
//#define STASSID "KT_GiGA_5G_Wave2_6FDC"
//#define STAPSK  "0fe00zb264"

#define STASSID "Sekyu"
#define STAPSK  "tlstprb1191"

#endif

const char* ssid     = STASSID;
const char* password = STAPSK;

//const char* host = "192.168.0.5";
//const char* host = "192.168.43.110";
const uint16_t port = 3000;
const char* host = "172.16.110.102";

WiFiClient client;


void setup()
{
  Serial.begin(115200);
  delay(10);
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.println("Server connection Start");

    while (!client.connect(host,port)) {
    delay(500);
    Serial.print(".");
  }
    Serial.println("client connect!");
  
}

void loop(){
    static char min_count = 0;
    String data;
     //Serial.printf("coneected state %d \n",client.connected());
     Serial.printf("count = %d\n",min_count);
     
     while(!client.connect(host,port)); //연결 가능할시
         if(min_count == 4) {
          client.write("Arduino_schedule\n");
          Serial.println("Arduino_schedule\n");
          min_count =0;
         }else {
          client.write("Arduino\n");
          Serial.println("Arduino\n");
          min_count++;
         }
         
         data = client.readStringUntil('\n');
         data[data.length()+1] = '\n';
         Serial.println(data);
         
         delay(1*10*1000);
    
}
