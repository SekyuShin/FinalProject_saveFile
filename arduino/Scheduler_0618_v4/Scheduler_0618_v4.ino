#include<SoftwareSerial.h>
#include<Wire.h>
#include "ESP8266.h"
//////////////////////////////////////////////////////////////////
#include <Adafruit_NeoPixel.h>   // 네오픽셀 라이브러리를 불러옵니다.

#define PIN 5                      // 디지털핀 어디에 연결했는지 입력
#define LEDNUM 24                  // 연결된 네오픽셀의 숫자입력
#define LED_S_BRIGHT 70             // led strip 밝기
//////////////////////////////////////////////////////////////////
#ifndef STASSID
//#define STASSID "WIFI_SHIN"
//#define STAPSK  "s7221191"
//#define STASSID "KT_GiGA_5G_Wave2_6FDC"
//#define STAPSK  "0fe00zb264"

#define STASSID "Sekyu"
#define STAPSK  "tlstprb1191"
#endif


#define REALTIME now.arr[0]
#define POP now.arr[1]
#define TMX now.arr[2]
#define TMN now.arr[3]
#define SKY now.arr[4]
#define PTY now.arr[5]
#define T1H now.arr[6]
#define START ListArr[0]
#define END ListArr[1]
#define TEXT ListArr[2]

//0.1 -> 비 
//1 -> 시계 카운트, 텍스트
//60 -> 날씨정보, 시간정보 or 일정정보(led)
//300 -> 일정정보(led)

//base + tcpInterface

const char* ssid     = STASSID;
const char* password = STAPSK;

const char* host = "172.16.110.102";
//const char* host = "13.125.131.249";

//const uint16_t port = 80;
const uint16_t port = 3000;
ESP8266 wifi(Serial3,115200);
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

List *list;
Weather now;
String data,dataList; //tcp로 부터 받아온 정보와 따로 보관할 일정정보
unsigned char listCount; //리스트 길이

unsigned long timeVal; //이전시간
unsigned long readTime;

void parsingClock(String);
void showClock(); //삭제 예정
String toStringData(char *sel); //날씨정보와 리스트 string화
void parsingStr(); //데이터 파싱 함수
void ShowParsingData(); //삭제예정


void setup()
{
  color whatColor;
  Serial.begin(115200);
  Serial.print("setup begin\r\n");
  delay(100);
    strip.begin();                           // 네오픽셀 제어시작
    strip.show();  
    for(int i=0;i<240;i+=5) {
     whatColor = setColor(i/10);
     strip.setPixelColor(i/5, whatColor.r,whatColor.g ,whatColor.b);
   }
   
   delay(100);
   strip.show();
    wifi.restart();
    if(wifi.kick ())
      Serial.print("esp8266 is alive\r\n");
    else
      Serial.print("esp8266 is not alive\r\n");
      
    Serial.print("FW Version:");
    Serial.println(wifi.getVersion().c_str());
 
    if (wifi.setOprToStation ()) {
        Serial.print("to station mode\r\n");
    } else {
        Serial.print("to station mode error\r\n");
    }
 
     if (wifi.disableMUX()) {
        Serial.print("single ok\r\n");
    } else {
        Serial.print("single err\r\n");
    }
  
   
   Serial.println("client connect!");
    while(!wifi.joinAP(ssid, password))Serial.print(".");
    Serial.print("IP:");
    Serial.println( wifi.getLocalIP().c_str()); 
    tcpInterface(true);
    parsingClock(toStringData(&REALTIME));
    timeVal = millis();
    ledControl(); ///////////////////////////////////////////////
}

void loop()
{
  static boolean ledStripOnOff = false;
  if(millis()-timeVal>=100){ //1초 단위 출력
     readTime +=(millis()-timeVal);
     timeVal = millis();
     
     if(readTime>=86400000){
       Serial.println(readTime);
       readTime=0;
     }
    if((readTime/100)%10==0) { //초단위     
        showClock(); 
        if((readTime/100)%3000==0) { //5분단위
           Serial.println("5분단위");
           tcpInterface(true);
        }else if((readTime/100)%600==0) { //1분단위
           Serial.println("1분단위");
           tcpInterface(false);
        } 
        ////////////////////////////////
        if(ledStripOnOff) {
          curTimeOnOff(ledStripOnOff);
        }else {
          curTimeOnOff(-1);
        }
        ledStripOnOff = !ledStripOnOff;
        
        ///////////////////////
     }
    
  }
}
void tcpInterface(boolean scheduleOnoff) {
  unsigned char buffer[512] = {0};
  Serial.println("start tcp");
  
  if(!wifi.createTCP(host, port)){
    Serial.println("server not found");
    wifi.createTCP(host, port);
    if(!wifi.joinAP(ssid, password)) {
      Serial.print("wifi disconnect");
      wifi.joinAP(ssid, password);
    } 
    if(!wifi.createTCP(host, port)&&!wifi.joinAP(ssid, password)) {
      return;
    }
    
  }
  
  if(scheduleOnoff) {
    char* str = "Arduino schedule\n";
    Serial.println("sending");
    wifi.send((const uint8_t*)str, strlen(str));
    Serial.println("recv");
    wifi.recv(buffer, sizeof(buffer), 10000);
    if(buffer[0] == NULL) return;
    data=buffer;
    Serial.println(data);
    
  } else {
   char* str = "Arduino\n";
    Serial.println("sending");
    wifi.send((const uint8_t*)str, strlen(str));
    Serial.println("recv");
    wifi.recv(buffer, sizeof(buffer), 10000);
    if(buffer[0] == NULL) return;
    data=buffer;
    Serial.println(data);

  }
       
   parsingStr();
   parsingClock(toStringData(&REALTIME));
   ShowParsingData(); //삭제예정
   ledControl();
   
}
void ShowParsingData() { //삭제예정
   Serial.println("================================");
  Serial.println(toStringData(&REALTIME));
  Serial.println(toStringData(&POP));
  Serial.println(toStringData(&TMX));
  Serial.println(toStringData(&TMN));
  Serial.println(toStringData(&SKY));
  Serial.println(toStringData(&PTY));
  Serial.println(toStringData(&T1H));
  for(int i=0;i<listCount;i++) {
    Serial.println(toStringData(&list[i].START));
    Serial.println(toStringData(&list[i].END));
    Serial.println(toStringData(&list[i].TEXT));
  }
}

void parsingStr() {
  char i=0;
  int section;
  boolean out = true;
  //Serial.println(POP);
  
  int isList;
  
  Serial.println( data.indexOf('&'));
  if((isList= data.indexOf('&')) != -1) {
    if(data.indexOf("!?") != -1){ //빈 리스트
      free(list);
      list = NULL;
      dataList = "";
      data.remove(isList);
      listCount = 0;
      Serial.println("빈 리스트");
    }else { //리스트 존재
       free(list);
       list = NULL;
       dataList = data.substring(isList+1,data.length());
       data.remove(isList);
       listCount = (dataList.substring(0,dataList.indexOf('_'))).toInt();
       //count = atoi(data[isList+1]);
       Serial.print("list size : ");
       Serial.println(listCount,DEC);
       list = (List*)malloc(sizeof(List)*listCount);   
    }
  }else { // 날짜데이터만
    Serial.println("날짜데이터");
    out = false;
  }

 
  for(i=0;i<7;i++) { //re
    section = data.indexOf('_');
    //Serial.println(section,DEC);
    
    if(section <0) {
           section = data.length();
         }
    //Serial.println(section,DEC);
    now.arr[i]=section;
    data[section] = '/';    
//     {
//      list[(i-7)/3].ListArr[(i-7)%3] = section;
//    }
  }
  if(out) {
    dataList[dataList.indexOf('_')] = '/';
    for(i = 0;i <listCount*3;i++) {
       section = dataList.indexOf('_');
       //Serial.println(section,DEC);
    
       if(section <0) {
           section = dataList.length();
         }
      list[i/3].ListArr[i%3] = section;
      dataList[section] = '/';
    }
  }
}

String toStringData(char *sel) {
  if(&REALTIME == sel) {  
    return data.substring(0,REALTIME);
  }else if(&POP == sel) {
    return data.substring(REALTIME+1,POP);
  }else if(&TMX == sel) {
    return data.substring(POP+1,TMX);
  }else if(&TMN == sel) {
    return data.substring(TMX+1,TMN);
  }else if(&SKY == sel) {
    return data.substring(TMN+1,SKY);
  }else if(&PTY == sel) {
    return data.substring(SKY+1,PTY);
  }else if(&T1H == sel) {
    return data.substring(PTY+1,T1H);
  }
   for(int i =0;i<listCount*3;i++) {
    if(&(list[i].START) == sel) {
      if(i==0) {
        return dataList.substring(dataList.indexOf('/')+1,list[i].START);
      }else {
        return dataList.substring(list[i-1].TEXT+1,list[i].START);
      }
      
    }else if(&(list[i].END) == sel) {
      return dataList.substring(list[i].START+1,list[i].END);
    }else if(&(list[i].TEXT) == sel) {
      return dataList.substring(list[i].END+1,list[i].TEXT);
    }
  }
}
void showClock() {
  int rHour,rMin,rSec;
  rSec = (readTime/1000)%60; //delete
  rMin = (readTime/60000)%60;
  rHour = (readTime/(60*60000))%24; 
  Serial.print(readTime);
  Serial.print(" : ");
  Serial.print(rHour,DEC);
  Serial.print(" : ");
  Serial.print(rMin,DEC);
  Serial.print(" : ");
  Serial.println(rSec,DEC); //delete
  
}

void parsingClock(String str) {
  char rHour,rMin,rSec;
  rHour = (str.substring(0,3)).toInt();
  rMin = (str.substring(3,6)).toInt();
  rSec = (str.substring(6,9)).toInt();
  readTime = ((long)rHour*3600+rMin*60+rSec)*1000;
}


/////////////////////////////////////////////////////////////////////////////////

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
ledStrip* ledSetting() { //ledStrip 색깔과 start, end 셋팅
  static ledStrip *led = NULL;
  color whatColor;
  int i;
  if(listCount) { 
    free(led);
    led = NULL;
      led = (ledStrip*)malloc(sizeof(ledStrip)*listCount);  
  } else {
    free(led);
    led = NULL;
    return led;
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
void curTimeOnOff(int cur_time) { //현재시간 onOff
  static unsigned char t;
  color c;
  strip.begin();                           // 네오픽셀 제어시작
  strip.show();                            // 네오픽셀 초기화 
  if(cur_time == -1) {
    c.r = cur_color.r;
    c.g = cur_color.g;
    c.b = cur_color.b;
  }else if( cur_time == 1) {
    c.r = 100;
    c.g = 100;
    c.b = 100;
  }else {
    t = cur_time;
    c.r = 100;
    c.g = 100;
    c.b = 100;
  } 
  
  
    if(t >=120) { //현재시간 led표시
     strip.setPixelColor((t-120)/5, c.r,c.g ,c.b);
    } else {
     strip.setPixelColor(t/5, c.r,c.g ,c.b);
  }
 
}



void ledControl() {
  ledStrip* led;
  unsigned char cur_time;
  boolean curCollect=false;
  boolean after;
  int st_j,en_j;
  
  strip.begin();                           // 네오픽셀 제어시작
  strip.show();                            // 네오픽셀 초기화
  for(int i = 0 ;i<24;i++) {
    strip.setPixelColor(i, 0,0,0);
  }
   led = ledSetting(); //led 세팅  
   cur_time = realTimeToLed();    //현재시간세팅
 
  Serial.print("cur_time");
  Serial.println(cur_time,DEC);
  
 if(cur_time>=120) { //오후 210 - 90(330)
  after = true;
 }else after =false;


for(int i =0 ;i<listCount;i++) {
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
      if(j==cur_time) {
        curCollect = true; //깜박이는거
        cur_color.r = led[i].r;
        cur_color.g = led[i].g;
        cur_color.b = led[i].b;        
      }
       
      if(j >=120) {
          if(j>=240) {
             strip.setPixelColor((j-240)/5, led[i].r,led[i].g , led[i].b);
          }else strip.setPixelColor((j-120)/5, led[i].r,led[i].g , led[i].b);
      } else {
         strip.setPixelColor(j/5, led[i].r,led[i].g , led[i].b);
      }
  } //Serial.println("");
 
}
  if(!curCollect) {
    cur_color.r = 0;
    cur_color.g = 0;
    cur_color.b = 0;
  }
  curTimeOnOff(cur_time);

    
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
  unsigned char temp;
  led_time = (readTime/(60*60000))%24;
  led_time*=10;
  temp = (readTime/60000)%60;
  if(temp<30) temp = 0;
  else temp = 5;
  led_time +=temp;
  Serial.println(led_time,DEC);
  return led_time;
}
/////////////////////////////////////////////////////////////////////////////////
