
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <ESP8266WiFi.h>
#include <string.h>

#ifndef STASSID
//#define STASSID "U+Net7E03"
//#define STAPSK  "415A003536"

#define STASSID "Sekyu"
#define STAPSK  "tlstprb1191"
#endif

const char* ssid     = STASSID;
const char* password = STAPSK;

const char* host = "13.125.131.249";
const uint16_t port = 80;

// Set the LCD address to 0x27 for a 16 chars and 2 line display
LiquidCrystal_I2C lcd(0x27, 16, 2);  // I2C LCD 객체 선언
WiFiClient client;

void lcdShow(int i,String str) {
  switch(i) {
    case 0 :
      lcd.clear();
      lcd.setCursor(0,i);
      break;
    case 1 :
      lcd.setCursor(0,i);
      break;
  }
  lcd.print(str);
}

void setup()
{
  lcd.begin(); // lcd를 사용을 시작합니다.
  lcd.backlight(); // backlight를 On 시킵니다.
  lcd.setCursor(0,0);
  lcd.print("Hello, world!"); // 화면에 Hello, world!를 출력합니다.
  
  Serial.begin(115200);
  delay(10);
  // We start by connecting to a WiFi network

  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  lcdShow(0,"Connecting to ");

   WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("");
  Serial.println("WiFi connected");
  lcdShow(0,"WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.println("Server connection Start");

    while (!client.connect(host,port)) {
    delay(500);
    Serial.print(".");
  }
    Serial.println("client connect!");
    lcdShow(0,"client connect!");
  
}

void loop(){
     lcdShow(0,"Server Connect");
     String str1,str2;
     Serial.printf("coneected state %d \n",client.connected());
     
     
     while(client.connected()) { //연결 가능할시
       
         
         client.write("Arduino\n");
         String recevbline = client.readStringUntil('\n');
         
         Serial.println(recevbline);
         int count=0;
          for (int i=1;i<recevbline.length();i++) {
            if(recevbline[i] == '/') {
              count = i;
             break;
            }
          }
         str1=recevbline.substring(0,count);
         str2=recevbline.substring(count,recevbline.length());
         lcdShow(0,str1);
         lcdShow(1,str2);
       
     
     delay(1*30*1000);
    }

    while(!client.connect(host,port)) {
      Serial.println("Server disconnect");
      lcdShow(0,"Server disconnect");
      delay(5000);
    }
}
