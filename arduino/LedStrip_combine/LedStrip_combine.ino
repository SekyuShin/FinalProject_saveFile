nek0427
#include <Adafruit_NeoPixel.h>   // 네오픽셀 라이브러리를 불러옵니다.
#include<Wire.h>

#define PIN 5                      // 디지털핀 어디에 연결했는지 입력
#define LEDNUM 24                  // 연결된 네오픽셀의 숫자입력
#define LED_S_BRIGHT 20             // led strip 밝기
Adafruit_NeoPixel strip = Adafruit_NeoPixel(LEDNUM, PIN, NEO_GRB + NEO_KHZ800);

typedef struct {
  char st;
  char en;
  char r = 0;
  char g = 0;
  char b = 0;
}ledStrip;


typedef struct {
  char r;
  char g;
  char b;
}color;

color setColor(char);
int realTimeToLed();
int listToLed(String);
ledStrip* ledSetting();
void ledControl();


void setup() {
    //testsetupList(
  
   strip.begin();                           // 네오픽셀 제어시작
   strip.show();                            // 네오픽셀 초기화 
   ledControl();
   Serial.begin(115200);
   
}

void loop() {                              // 이 안에 입력한 내용들이 반복 실행됩니다
    
    ledControl();
    delay(1000);
}

color setColor(char whatColor) { //0-23
  color wc;
  char colorArray[] = {200,210,220,120, 20, 21, 22, 12,  2,102,202,201};
  char colorArray2[] = {311,321,331,231,131,132,133,123,113,213,313,312};
  char temp;
  
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
ledStrip* ledSetting() {
  static ledStrip *led = NULL;
  color whatColor;
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
  
  for(i = 0;i<listCount;i++) {
    led[i].st = listToLed(toStringData(&list[i].START));
    led[i].en = listToLed(toStringData(&list[i].END));
    whatColor = setColor(led[i].st/10);
    led[i].r = whatColor.r;
    led[i].g = whatColor.g;
    led[i].b = whatColor.b;
  }
  return led;
}



void ledControl() {
  ledStrip* led;
  char cur_time;
  boolean after;
  int st_j,en_j;
  
   led = ledSetting(); //led 세팅
   strip.begin();                           // 네오픽셀 제어시작
   strip.show();                            // 네오픽셀 초기화
   cur_time = realTimeToLed();    //현재시간세팅
 
  Serial.print("cur_time");
  Serial.println(cur_time,DEC);
 if(cur_time>=120) { //오후 210 - 90(330)
  after = true;
 }else after =false;

 if(cur_time == 0)strip.setPixelColor(23, 0,0,0); //전의 현재시간 지우기 수정할수도
 else {
  if(cur_time >=120) {
     strip.setPixelColor((cur_time-125)/5, 0,0 ,0);
  } else {
     strip.setPixelColor((cur_time-5)/5, 0,0,0);
  }
 }


for(int i =0 ;i<count;i++) {
    if(after) { //오후
      if(led[i].st>led[i].en) { // 210,15
        st_j = led[i].st;
        en_j = led[i].en+240;
      } else if (cur_time<led[i].en){ //200,230
        st_j = led[i].st;
        en_j = led[i].en;
      } else { // 10,30 // 20,45 // 40,100 
        st_j = led[i].st+240;
        en_j = led[i].en+240;
      }
    } else { //오전
      if(led[i].st>led[i].en && cur_time <= led[i].en) {
         st_j = cur_time;
         en_j = led[i].en;
      }else if(led[i].st>led[i].en) { 
        st_j = led[i].st;
        en_j = led[i].en+240;
      }else {
         st_j = led[i].st;
         en_j = led[i].en;
      }
     
    }//Serial.print("====j===:");
     for(int j=st_j;j<en_j ;j+=5) {
      if(j<cur_time || j>=cur_time+120) continue;
      
      //Serial.print("  :  ");
      //Serial.print(j);
      
      if(j >=120) {
          if(j>=240) {
             strip.setPixelColor((j-240)/5, led[i].r,led[i].g , led[i].b);
          }else strip.setPixelColor((j-120)/5, led[i].r,led[i].g , led[i].b);
      } else {
         strip.setPixelColor(j/5, led[i].r,led[i].g , led[i].b);
      }
  } //Serial.println("");
 
}
    if(cur_time >=120) { //현재시간 led표시
     strip.setPixelColor((cur_time-120)/5, 100,100 ,100);
    } else {
     strip.setPixelColor(cur_time/5, 100,100 ,100);
    }
    
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

int realTimeToLed() {
  int led_time;
  char temp;
  led_time = (readTime/(60*60000))%24;
  temp = (readTime/60000)%60;
  if(temp<30) temp = 0;
  else temp = 5;
  led_time +=temp;
  Serial.println(led_time,DEC);
  return led_time;
}
