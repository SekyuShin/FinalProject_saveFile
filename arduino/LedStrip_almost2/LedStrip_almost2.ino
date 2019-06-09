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
  String st;
  String en;
  String text;
}testList;

//testList testlist[] = {{"201906080010","201906080310","test1"},{"201906080600","201906080700","test2"},{"201906091100","201906091300","test3"}};
//testList testlist[] = {{"201906091500","201906091700","test4"},{"201906091900","201906092000","test5"},{"201906092300","201906090100","test6"}};
//testList testlist[] = {{"201906080010","201906080310","test1"},{"201906080600","201906080700","test2"},{"201906091100","201906091300","test3"},{"201906091500","201906091700","test4"},{"201906091900","201906092000","test5"},{"201906092300","201906090100","test6"}};
testList testlist[] = {{"201906092300","201906090100","test5"},{"201906090200","201906090400","test6"},{"201906080600","201906080700","test2"},{"201906080800","201906081200","test1"}};
//230 - 10// 11-01, 02-04, 
String RealTime = "00:20:30";//235 - 115  0


int count = 4;

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
      Serial.print("=");
      Serial.print(led[i].en,DEC);
      Serial.println("=========");
      
    switch(i%2) { //밝기 조절 필요
        case 0:
          led[i].r = 0;
          led[i].g = led[i].st/10+LED_S_BRIGHT;
          led[i].b = led[i].en/10+LED_S_BRIGHT;
          break;
        case 1:
          led[i].g = led[i].en/10+LED_S_BRIGHT;
          led[i].b = led[i].st/10+LED_S_BRIGHT;
          led[i].r = 0;
          break;
        
      }
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
      }else {
         st_j = led[i].st;
         en_j = led[i].en;
      }
     
    }Serial.print("====j===:");
     for(int j=st_j;j<en_j ;j+=5) {
      if(j<cur_time || j>=cur_time+120) continue;
      
      Serial.print("  :  ");
      Serial.print(j);
      
      if(j >=120) {
          if(j>=240) {
             strip.setPixelColor((j-240)/5, led[i].r,led[i].g , led[i].b);
          }else strip.setPixelColor((j-120)/5, led[i].r,led[i].g , led[i].b);
      } else {
         strip.setPixelColor(j/5, led[i].r,led[i].g , led[i].b);
      }
  } Serial.println("");
 
}
    if(cur_time >=120) { //현재시간 led표시
     strip.setPixelColor((cur_time-120)/5, 100,0 ,0);
    } else {
     strip.setPixelColor(cur_time/5, 100,0,0);
    }
}


void setup() {
    //testsetupList(
  
   strip.begin();                           // 네오픽셀 제어시작
   strip.show();                            // 네오픽셀 초기화 
   Serial.begin(115200);
   Serial.println("=========start===========");
}


void loop() {                              // 이 안에 입력한 내용들이 반복 실행됩니다
    ledControl();
    realTimeToLed();
    delay(2000);
}
