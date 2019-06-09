
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
  readTime = ((long)rHour*3600+rMin*60+rSec)*10;
}

void showClock() {
  int rHour,rMin,rSec;
  rSec = (readTime/10)%60; //delete
  rMin = (readTime/600)%60;
  rHour = (readTime/(60*600))%24; 
  
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
}

void loop()
{
  if(millis()-timeVal>=100){ //1초 단위 출력
     timeVal = millis();
     readTime +=1;
     if(readTime>=864000000){
       readTime=0;
     }
    if(readTime%10==0) { //초단위     
        showClock(); 
        if(readTime%3000==0) { //5분단위
           Serial.println("5분단위");
        }else if(readTime%600==0) { //분단위
           Serial.println("1분단위");
        } 
     }
      
      
           
  }
}
