#include <Adafruit_NeoPixel.h>   // 네오픽셀 라이브러리를 불러옵니다.
#include<Wire.h>

#define PIN 5                      // 디지털핀 어디에 연결했는지 입력
#define LEDNUM 24                  // 연결된 네오픽셀의 숫자입력
#define LED_S_BRIGHT 100             // led strip 밝기
Adafruit_NeoPixel strip = Adafruit_NeoPixel(LEDNUM, PIN, NEO_GRB + NEO_KHZ800);

typedef struct {
  char st;
  char en;
  char r = 0;
  char g = 0;
  char b = 0;
}ledStrip;

typedef struct {
  String st;
  String en;
  String text;
}testList;

testList testlist[] = {{"201906080010","201906080310","test1"},{"201906080600","201906080700","test2"},{"201906091100","201906091300","test3"}};
String RealTime = "18:10:30";

int count = 3;

int realTimeToLed() {
  int led_time;
  char temp;
  led_time = (RealTime.substring(0,3)).toInt()*10;
  temp = (RealTime.substring(3,5)).toInt();
  if(temp<30) temp = 0;
  else temp = 5;
  led_time +=temp;
  Serial.println(led_time,DEC);
  return led_time;
}

int listToLed(String str) {
  int ledClock;
  char temp;
  
  ledClock = (str.substring(8,str.length())).toInt();
  temp = ledClock%100;
  ledClock/=100;
  ledClock*=10;
  if(temp>15 && temp<45) {
    temp = 5;
  }else {
    
    if(temp>=45) temp = 10;
    else temp = 0;
  }
  
  ledClock+=temp;
  
  return ledClock;
}

ledStrip* ledSetting() {
  static ledStrip *led = NULL;
  int i;
  if(count) { 
    free(led);
    led = NULL;
     
      
      led = (ledStrip*)malloc(sizeof(ledStrip)*count);  
   
    
  } else {
    free(led);
    led = NULL;
    return 0;
  }
  
  for(i = 0;i<count;i++) {
      led[i].st = listToLed(testlist[i].st);
     
      led[i].en = listToLed(testlist[i].en);
      
      Serial.print("=ledstartend====");
      Serial.print(led[i].st,DEC);
      Serial.print(led[i].en,DEC);
      Serial.println("=========");
      
    switch(i%3) { //밝기 조절 필요
        case 0:
          led[i].r = 0;
          led[i].g = led[i].st;
          led[i].b = led[i].en;
          break;
        case 1:
          led[i].g = 0;
          led[i].b = led[i].st;
          led[i].r = led[i].en;
          break;
        case 2:
          led[i].b = 0;
          led[i].r = led[i].st;
          led[i].g = led[i].en;
          break;
      }
  }
  return led;
}

void setup() {
    //testsetupList(
  
   strip.begin();                           // 네오픽셀 제어시작
   strip.show();                            // 네오픽셀 초기화 
   Serial.begin(115200);
   Serial.println("=========start===========");
}

void ledControl() {
  ledStrip* led;
  char cur_time;
  led = ledSetting();
  
   strip.begin();                           // 네오픽셀 제어시작
   strip.show();                            // 네오픽셀 초기화
   cur_time = realTimeToLed();
   for(int i =0;i<count;i++) {
        Serial.print("=color===");
        Serial.print(led[i].r,DEC);
        Serial.print("=");
        Serial.print(led[i].g,DEC);
        Serial.print("=");
        Serial.println(led[i].b,DEC);
     for(int j=led[i].st;j<led[i].en;j+=5){
        if(j >=120) {
         strip.setPixelColor((j-120)/5, led[i].r,led[i].g , led[i].b);
         }
        else {
         strip.setPixelColor(j/5, led[i].r,led[i].g , led[i].b);
        }
     }
   }
        
        if(cur_time >=120) {
         strip.setPixelColor((cur_time-120)/5, 100,0 ,0);
         }
        else {
         strip.setPixelColor(cur_time/5, 0,0,0);
        }
        
         
  
}

void loop() {                              // 이 안에 입력한 내용들이 반복 실행됩니다
    ledControl();
    realTimeToLed();
    delay(5000);
}
