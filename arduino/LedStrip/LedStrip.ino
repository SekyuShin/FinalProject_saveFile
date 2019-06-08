#include <Adafruit_NeoPixel.h>   // 네오픽셀 라이브러리를 불러옵니다.
#include<Wire.h>

#define PIN 5                      // 디지털핀 어디에 연결했는지 입력
#define LEDNUM 24                  // 연결된 네오픽셀의 숫자입력
#define LED_S_BRIGHT 45             // led strip 밝기
Adafruit_NeoPixel strip = Adafruit_NeoPixel(LEDNUM, PIN, NEO_GRB + NEO_KHZ800);

typedef struct {
  boolean onOff=false;
  char r = 0;
  char g = 0;
  char b = 0;
}ledStrip;

typedef struct {
  char st;
  char en;
}testList;

//15-35, 60-70 ,105-120
//3 - 7, 12-14, 21-24 //45
 ledStrip* setting() {
  static ledStrip led[24];
  char j=0;
  testList list[3] = {{3,7},{12,14},{21,24}};

  for(int i =0;i<24 ; i++) {
    if(i>=list[j].st && i<=list[j].en) {
      led[i].onOff = true;
      switch(j%3) {
        case 0:
        break;
        case 1:
        break;
        case 2:
        break;
      }
      if(j%3 == 0) {
        led[i].g = list[j].st;
        led[i].b = list[j].en;
      }else if(j%3 == 1) {
        led[i].b = list[j].st;
        led[i].r = list[j].en;
      }else {
        led[i].r = list[j].st;
        led[i].g = list[j].en;
      }
      if(i == list[j].en) j++;
    }
  }
  
  return led;
}
void setup() {
   strip.begin();                           // 네오픽셀 제어시작
   strip.show();                            // 네오픽셀 초기화 
}

void ledControl() {
  ledStrip* led;
  led = setting();
   strip.begin();                           // 네오픽셀 제어시작
   strip.show();                            // 네오픽셀 초기화
   for(int i =0;i<24;i++) {
    if(led[i].onOff) {
       strip.setPixelColor(i, led[i].r,led[i].g , led[i].b);
    }
   }
}

void loop() {                              // 이 안에 입력한 내용들이 반복 실행됩니다
    
    
    ledControl();
    delay(5000);
}
