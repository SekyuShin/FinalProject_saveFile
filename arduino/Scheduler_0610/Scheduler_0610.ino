
#include<Wire.h>
#include <ESP8266WiFi.h>

#ifndef STASSID
#define STASSID "WIFI_SHIN"
#define STAPSK  "s7221191"
//#define STASSID "KT_GiGA_5G_Wave2_6FDC"
//#define STAPSK  "0fe00zb264"

//#define STASSID "Sekyu"
//#define STAPSK  "tlstprb1191"
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

const char* host = "192.168.0.6";
//const char* host = "172.30.1.32";
const uint16_t port = 3000;

WiFiClient client;

typedef struct { //일정 리스트 구조체
  char ListArr[3]; //START,END,TEXT
}List;


typedef struct { // 날씨정보 구조체
  char arr[7]; //REALTIME, POP,TMX,TMN,SKY,PTY,T1H
}Weather;
List *list;
Weather now;
String data,dataList; //tcp로 부터 받아온 정보와 따로 보관할 일정정보
char listCount; //리스트 길이

unsigned long timeVal; //이전시간
unsigned long readTime;

void parsingClock(String);
void showClock(); //삭제 예정
String toStringData(char *sel); //날씨정보와 리스트 string화
void parsingStr(); //데이터 파싱 함수
void ShowParsingData(); //삭제예정


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
    //바로 tcp연결 코드 추가 예정
    tcpInterface(true);
    parsingClock(toStringData(&REALTIME));
    timeVal = millis();
}

void loop()
{
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
     }
    
  }
}
void tcpInterface(boolean scheduleOnoff) {
  while(!client.connect(host,port));
  if(scheduleOnoff) {
    client.write("Arduino_schedule\n");
  } else {
    client.write("Arduino\n");
  }
  
  data = client.readStringUntil('\n');
  //data[data.length()+1] = '\n';
   Serial.println(data);
   Serial.println(dataList);
         
   parsingStr();
   parsingClock(toStringData(&REALTIME));
   ShowParsingData(); //삭제예정
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
  char t_count =0;
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
    Serial.println(section,DEC);
    
    if(section <0) {
           section = data.length();
         }
    Serial.println(section,DEC);
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
       Serial.println(section,DEC);
    
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
