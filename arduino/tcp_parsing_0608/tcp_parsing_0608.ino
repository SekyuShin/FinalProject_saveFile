
#include <Wire.h>
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


const char* ssid     = STASSID;
const char* password = STAPSK;

const char* host = "192.168.0.5";
//const char* host = "172.30.1.32";
const uint16_t port = 3000;

WiFiClient client;

typedef struct {
  char ListArr[3]; //START,END,TEXT
}List;


typedef struct {
  char arr[7]; //REALTIME, POP,TMX,TMN,SKY,PTY,T1H
}Weather;
List *list;
Weather now;
String data,dataList;
char count;
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
  
  for(int i =0;i<count*3;i++) {
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

void parsingStr(char min_count) {
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
      count = 0;
      Serial.println("빈 리스트");
    }else { //리스트 존재
       free(list);
       list = NULL;
       dataList = data.substring(isList+1,data.length());
       data.remove(isList);
       count = (dataList.substring(0,dataList.indexOf('_'))).toInt();
       //count = atoi(data[isList+1]);
       Serial.print("list size : ");
       Serial.println(count,DEC);
       list = (List*)malloc(sizeof(List)*count);   
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
    for(i = 0;i <count*3;i++) {
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
void ShowParsingData() {
   Serial.println("================================");
  Serial.println(toStringData(&REALTIME));
  Serial.println(toStringData(&POP));
  Serial.println(toStringData(&TMX));
  Serial.println(toStringData(&TMN));
  Serial.println(toStringData(&SKY));
  Serial.println(toStringData(&PTY));
  Serial.println(toStringData(&T1H));
  for(int i=0;i<count;i++) {
    Serial.println(toStringData(&list[i].START));
    Serial.println(toStringData(&list[i].END));
    Serial.println(toStringData(&list[i].TEXT));
  }
  
}
void loop(){
    static char min_count = 4;
    
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
         Serial.println(dataList);
         
         parsingStr(min_count);
         ShowParsingData();
        
         delay(1*10*1000);
    
}
