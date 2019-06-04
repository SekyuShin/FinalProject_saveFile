#include<Wire.h>

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


String str1 = "2019-05-27T16:55:04+09:00_1800:30_20_18_rain_m-cloudy_18"; //8
String str2 = "2019-05-27T16:57:37+09:00_1800:30_20_18_rain_m-cloudy_18_170_180_test";
String str3 = "2019-05-27T16:57:37+09:00_1800:30_20_18_rain_m-cloudy_18_170_180_test_180_190_test1";
String str4 = "2019-05-27T16:57:37+09:00_1800:30_20_18_rain_m-cloudy_18_170_180_test_180_190_test1_200_210_test2";
// 7 10 13 16
//24 led strip => 5단위로 12시간 갱신120 넘어가면 -120

typedef struct {
  char ListArr[3]; //START,END,TEXT
}List;


typedef struct {
  char arr[7]; //REALTIME, POP,TMX,TMN,SKY,PTY,T1H
}Weather;
List *list;
Weather now;
String data;
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
  
  for(int i =0;i<24;i++) {
    if(&(list[i].START) == sel) {
      if(i==0) {
        return data.substring(T1H+1,list[i].START);
      }else {
        return data.substring(list[i-1].TEXT+1,list[i].START);
      }
      
    }else if(&(list[i].END) == sel) {
      return data.substring(list[i].START+1,list[i].END);
    }else if(&(list[i].TEXT) == sel) {
      return data.substring(list[i].END+1,list[i].TEXT);
    }
  }
}


void parsingStr() {
  char i=0;
  signed char section;
  boolean out = true;
  
  //Serial.println(POP);
  count =0;
  while(i<data.length()) {
     if(data[i] == '_') count++;
     i++;
  }
  //Serial.println(count,DEC);
  count = (count-6)/3;
  //Serial.println(count,DEC);
  free(list);
  list = NULL;
  if(count!=0) {
     //Serial.println("===realloc");
     //Serial.printf("count %d\n",count);
     list = (List*)malloc(sizeof(List)*count);
     //Serial.printf("%d",list);
     //realloc(list,sizeof(List)*count);
    
  }
  i=0;
  
  while(out) { //re
    //Serial.println(section,DEC);
    section = data.indexOf('_');
    if(section ==-1) {
           section = data.length();
           out = false;
         }
         
    if(i<7) {
      now.arr[i]=section;
        
    } else {
      list[(i-7)/3].ListArr[(i-7)%3] = section;
    }
//      Serial.print(i,DEC);
//      Serial.print("==========");
//      //Serial.print(now.arr[i],DEC);
//      Serial.print("==========");
//      Serial.println(data.substring(0,section));
      data[section] = '/';
    i++;
  }
  
}


void setup()
{
  Serial.begin(115200);
}

void loop()
{ static char liCo=0;
  signed char section,section2;
  liCo++;
  switch(liCo) {
    case 0: 
      data = str1;
      break;
    case 1: 
      data = str2;
      break;
    case 2: 
      data = str3;
      break;
    case 3: 
      data = str4;
      liCo = 0;
      break;
  }
  parsingStr();
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
  
  delay(30*1000);
  

}
