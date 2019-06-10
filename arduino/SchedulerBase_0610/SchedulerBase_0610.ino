
#include<Wire.h>


//0.1 -> 비 
//1 -> 시계 카운트, 텍스트
//60 -> 날씨정보, 시간정보 or 일정정보(led)
//300 -> 일정정보(led)


String realTime = "23:59:50";


unsigned long timeVal; //이전시간
unsigned long readTime;
void parsingClock(String str) {
  char rHour,rMin,rSec;
  rHour = (str.substring(0,3)).toInt();
  rMin = (str.substring(3,6)).toInt();
  rSec = (str.substring(6,9)).toInt();
  readTime = ((long)rHour*3600+rMin*60+rSec)*1000;
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
void setup()
{
  Serial.begin(115200);  
  parsingClock(realTime);
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
        }else if((readTime/100)%600==0) { //분단위
           Serial.println("1분단위");
           delay(1350); //test
        } 
     }
      
      
           
  }
}
