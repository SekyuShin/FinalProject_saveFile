
#include <Wire.h>

String str1 = "2019-05-27T16:55:04+09:00_1800:30_20_18_rain_m_cloudy_18\n"; //8
String str2 = "2019-05-27T16:57:37+09:00_1800:30_20_18_rain_m_cloudy_18_170_180_test\n";
String str3 = "2019-05-27T16:57:37+09:00_1800:30_20_18_rain_m_cloudy_18_170_180_test_170_180_test1\n";
String str4 = "2019-05-27T16:57:37+09:00_1800:30_20_18_rain_m_cloudy_18_170_180_test_170_180_test1_170_180_test2\n";
// 7 10 13 16
//24 led strip => 5단위로 12시간 갱신120 넘어가면 -120



typedef struct {
  String today_now;
}Time;

typedef struct {
  String pop,tmn,tmx,sky,t1h,pty;
}Weather;

typedef struct {
  String st_t,en_t,text;
}List;

List *list;
Weather weather;
Time now;

void parsingStr(String str) {
  char section,i=0,count=0;
  String var[10];
  while(str[i]!='\n') {
     if(str[i] == '_') count++;
     i++;
  }
  count = (count-7)/3;

  if(count!=0) {
    free(list);
    list = (List*)malloc(sizeof(List)*count);
  }
  
  i=0;
  (weather+0) ="hello";
//  while(str.length()) { //re
//    section = str.indexOf('_');
//    if(i==0) now.today_now = str.substring(0,section);
//    else if(i<7) {
//      weather[i-1]= str.substring(0,section);
//    } else {
//      list[i-7] = str.substring(0,section); 
//    }
//    str.remove(0,section+1);
//   i++;
//  }
  
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  delay(10);
  Serial.println();
  Serial.println();
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println(str2);
  parsingStr(str1);
  Serial.println(now);
  delay(50000);
  
  Serial.println(str2);
  delay(5000);
}
