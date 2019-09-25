#include <Adafruit_GFX.h>     // 아두의노의 핵심그래픽 라이브러리
#include <RGBmatrixPanel.h> 
#include <Adafruit_NeoPixel.h> 
#define PIN 5                      // 디지털핀 어디에 연결했는지 입력
#define LEDNUM 24                  // 연결된 네오픽셀의 숫자입력
#define LED_S_BRIGHT 70             // led strip 밝기

#define CLK 11      // GPIO 
#define LAT 10
#define OE  9
#define A   A0
#define B   A1
#define C   A2
#define D   A3
RGBmatrixPanel matrix(A, B, C, D, CLK, LAT, OE, false, 64); // 도트매트릭스 사전세팅
int    aY   = matrix.width(); // 매트릭스의 가로길이를 변수화, 여기서는 64
typedef struct { 
  char x = 40;
  char y = 40;
}XY;

Adafruit_NeoPixel strip = Adafruit_NeoPixel(LEDNUM, PIN, NEO_GRB + NEO_KHZ800); //////////////////////
typedef struct { //일정 리스트 구조체
  unsigned char ListArr[3]; //START,END,TEXT
}List;


typedef struct { // 날씨정보 구조체
  unsigned char arr[7]; //REALTIME, POP,TMX,TMN,SKY,PTY,T1H
}Weather;

//////////////////////////////////////////////////////////////////

typedef struct {
  unsigned char st;
  unsigned char en;
  unsigned char r = 0;
  unsigned char g = 0;
  unsigned char b = 0;
}ledStrip;


typedef struct {
  unsigned char r;
  unsigned char g;
  unsigned char b;
}color;

color setColor(char);
int realTimeToLed();
int listToLed(String);
ledStrip* ledSetting();
void ledControl();
void curTimeOnOff(int);

color cur_color;
//////////////////////////////////////////////////////////////////
ledStrip *led = NULL;
List *list;
Weather now;
String data,dataList; //tcp로 부터 받아온 정보와 따로 보관할 일정정보
unsigned char listCount; //리스트 길이

unsigned long timeVal; //이전시간
unsigned long readTime;



void setup() {
  color whatColor;
  Serial.begin(115200);
  Serial.print("setup begin\r\n");
  delay(100);
    strip.begin();                           // 네오픽셀 제어시작
    strip.show();  
    for(int i=0;i<240;i+=10) {
     whatColor = setColor(i/10);
     strip.setPixelColor(i/10, whatColor.r,whatColor.g ,whatColor.b);
   }strip.show();  
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:
  color whatColor;
  for(int i=0;i<240;i+=10) {
     whatColor = setColor(i/10);
     strip.setPixelColor(i/10, whatColor.r,whatColor.g ,whatColor.b);
   }strip.show();

}
color setColor(char whatColor) { //0-23 컬러 정하기
  color wc;
  int colorArray[] = {200,210,220,120, 20, 21, 22, 12,  2,102,202,201};
  int colorArray2[] = {311,321,331,231,131,132,133,123,113,213,313,312};
  int temp;
  
  switch(whatColor/12) { //밝기 조절 필요
        case 0:
        temp = colorArray[whatColor%12];
          wc.r = (temp/100)*LED_S_BRIGHT;
          temp%=100;
          wc.g = (temp/10*LED_S_BRIGHT);
          wc.b = (temp%10)*LED_S_BRIGHT;
          break;
        case 1:
           temp = colorArray2[whatColor%12];
           wc.r = (temp/100)*LED_S_BRIGHT;
          temp%=100;
          wc.g = (temp/10*LED_S_BRIGHT);
          wc.b = (temp%10)*LED_S_BRIGHT;
          break;
        
      }
      return wc;
}
