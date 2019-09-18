#include <Adafruit_GFX.h>     // 아두의노의 핵심그래픽 라이브러리
#include <RGBmatrixPanel.h>   // 도트매트릭스를 구현하기 위한 라이브러리
#include<Wire.h>    // ??????????????????
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
String matrixText[2]   = {"iaewewewewe","helllo"}; // 1번 스케줄 변수 
String tmx = "26",tmn = "13",t1h= "16",pty="snow",sky = "m-cloudy"; 
////////////////////////
String cur = "12:12:00";
///////////////////////

unsigned long timeVal; //이전시간
unsigned long readTime;

void (*weatherSky)();
void (*weatherPty)(int,int);

/*
 * 
 * 
 * 날씨 정보 set
 * 구름 지워지지 말게 (비올때 갱신)
 */


void setup() { // 아두이노를 원활하게 실행하기 위한 사전설정
  matrix.begin();
  Serial.begin(115200); // 시리얼통신(11520000hz)
  matrix.setTextWrap(false); //도트매트릭스를 화면 엣지(끝부분)까지 킬 수있도록 함
  matrix.setTextSize(1); // 매트릭스 글자크기설정(기본값 1)
  timeVal = millis();
  parsingClock(cur); ///////////////////////////////////////////////
  leftShift(false);//////////////////////////////////
  setWeather();
  
}

void parsingClock(String str) {////////////////////////////////////////////////
  char rHour,rMin,rSec;
  rHour = (str.substring(0,3)).toInt();
  rMin = (str.substring(3,6)).toInt();
  rSec = (str.substring(6,9)).toInt();
  Serial.print("parsing : ");
  Serial.print(rHour,DEC);
  Serial.print(": ");
  Serial.print(rMin,DEC);
  Serial.print(" : ");
  Serial.println(rSec,DEC);
  readTime = ((long)rHour*3600+rMin*60+rSec)*1000;
  Serial.print("readTime : ");
  Serial.println(readTime);
  
  
}

void showClock() {////////////////////////////////////////////////////////////
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
  watch(rHour,rMin);
  
}

void setWeather() {
           matrix.fillScreen(0);
           
           if(sky.indexOf("cloud")!=-1){
            weatherSky = Cloud;
           }else {
            weatherSky = Sun;//Sun(53,7); //sky
           }
           
           if(pty.indexOf("rain")!=-1 || pty.indexOf("shower")!= -1) {
            weatherPty = Rain;
           } else if(pty.indexOf("sleet")!=-1 || pty.indexOf("snow")!=-1) {
            weatherPty = Snow;
           } else {
            weatherPty = NULL;
           }
           
           temp(t1h,tmn,tmx);
           weatherSky();
                
           
}

void cur_time_test() {
  static boolean onOff = true;
  if(onOff) {
      matrix.setTextColor(matrix.Color333(1,2,3));
      matrix.setCursor(29,3);
      matrix.print('|');
  } else {
    matrix.setTextColor(matrix.Color333(0,0,0));
     matrix.setCursor(29,3); 
     matrix.print('|');
  }
  onOff = !onOff;
}

boolean downPosition() { // 도트매트릭스에 눈이나 비가 오는 기능을 구현하기 위한 함수
static XY location[8]; // 위 기능을 위해 XY좌표를 배열로 선언
static char count=0;

  if(count == 0) {
    for(int i =0;i<8;i++) {
        location[i].y = random(-10,0);  // 비나 눈효과를 좀 더 극적으로 주기 위해 
        location[i].x = random(-5,5);   // 랜덤으로 X,Y를 설정함
        if(location[i].x <0) (location[i].x)+=32; 
      }
  }
  for(int i =0;i<8;i++) { 
    location[i].y++;
    if(location[i].y>3) weatherPty(location[i].x,location[i].y); // 기상효과(비) 함수호출
  } 
  weatherSky();
  
  if(count >=50) {
    count =0;
    return false;
  } else {
    count++;
    return true;
  }
 
}

boolean leftShift(boolean shiftOnOff) {
  static int    textX   = 0,   
       textMin = (matrixText[0].length()+matrixText[1].length()+1)*-6; // 1번 스케줄(char형)의 사이즈 측정 
  if(!shiftOnOff) {
    matrix.setTextColor(matrix.Color333(5,9,9));
    matrix.setCursor(textX, 24);
    matrix.print(matrixText[0]);

    matrix.setTextColor(matrix.Color333(9,9,9));
    matrix.setCursor(textX+matrixText[0].length()*6+1, 24);
    matrix.print(matrixText[1]);
    
  }else {
    matrix.setTextColor(matrix.Color333(5,9,9));
    matrix.setCursor(textX, 24);
     matrix.print(matrixText[0]);
    matrix.setTextColor(matrix.Color333(9,9,9));
    matrix.setCursor(textX+matrixText[0].length()*6+6, 24);
    matrix.print(matrixText[1]);
  
    matrix.setTextColor(matrix.Color333(0,0,0));
    matrix.setCursor(textX+1, 24);
    matrix.print(matrixText[0]);
    matrix.setTextColor(matrix.Color333(0,0,0));
    matrix.setCursor(textX+matrixText[0].length()*6+7, 24);
    matrix.print(matrixText[1]);
    
     matrix.setTextColor(matrix.Color333(5,9,9));
     matrix.setCursor(textX, 24);
     matrix.print(matrixText[0]);
    matrix.setTextColor(matrix.Color333(9,9,9));
    matrix.setCursor(textX+matrixText[0].length()*6+6, 24);
    matrix.print(matrixText[1]);

  // Move text left (w/wrap)
   if(((--textX))< textMin) {
      textX = 0;
      shiftOnOff = false;
    }
    return shiftOnOff;
  }
}

void Rain(int x, int y) { // 기상효과(비) 함수
  matrix.drawLine(x*2,y,x*2,y+5,matrix.Color333(0,2,4)); // 비가 내리는 효과를 위하여 
  //matrix.drawPixel(x*2,y-1,matrix.Color333(0,0,0)); // 선을 그려서 떨어지게 만듦
  matrix.drawPixel(x*2, (y-1), matrix.Color333(0,0,0));
}

void Snow(int x, int y) { // 기상효과(눈) 함수
  matrix.drawCircle(x*2,y*2,1,matrix.Color333(0,2,4)); // 지름 1의 원을 그려서 
  matrix.drawCircle(x*2,(y*2)-2,1,matrix.Color333(0,0,0)); // 눈이 오는 효과를 낸다.
  matrix.drawCircle(x*2,y*2,1,matrix.Color333(0,2,4)); 
}

void Cloud() { // 기상효과(구름) 함수
  matrix.fillCircle(2,4,2,matrix.Color333(1,1,1)); // 구름이 뭉쳐있는 효과를 내기 위하여 흰색
  matrix.fillCircle(5,2,2,matrix.Color333(1,1,1)); // 원을 연이어 그려서 효과를 낸다.
  matrix.fillCircle(7,4,2,matrix.Color333(1,1,1));  
  matrix.fillCircle(56,4,2,matrix.Color333(1,1,1)); // 구름이 뭉쳐있는 효과를 내기 위하여 흰색
  matrix.fillCircle(59,2,2,matrix.Color333(1,1,1)); // 원을 연이어 그려서 효과를 낸다.
  matrix.fillCircle(61,4,2,matrix.Color333(1,1,1));  
}

void Sun(){ // 기상효과(맑음 또는 해) 함수
  matrix.fillCircle(53,7,2,matrix.Color333(1,1,0)); 
  matrix.drawLine(53,7+4,53,7+6,matrix.Color333(1,1,0)); // 위아래세로
  matrix.drawLine(53,7-4,53,7-6,matrix.Color333(1,1,0));
  matrix.drawLine(53+4,7,53+6,7,matrix.Color333(1,1,0)); // 좌우
  matrix.drawLine(53-4,7,53-6,7,matrix.Color333(1,1,0));
  matrix.drawLine(53+3,7+3,53+4,7+4,matrix.Color333(1,1,0));
  matrix.drawLine(53-3,7-3,53-4,7-4,matrix.Color333(1,1,0));
  matrix.drawLine(53+3,7-3,53+4,7-4,matrix.Color333(1,1,0));
  matrix.drawLine(53-3,7+3,53-4,7+4,matrix.Color333(1,1,0));
}

void watch(int hour,int minute){ // 시계함수 ////////////////////////////////////////////
  String tempHour = "00"+String(hour);
  String tempMin = "00"+String(minute);
  Serial.print("recieve matrix watch => ");
  Serial.print(hour,DEC);
  Serial.print(" : ");
  Serial.println(tempMin);
  tempHour = tempHour.substring(tempHour.length()-2);
  tempMin = tempMin.substring(tempMin.length()-2);
  matrix.setTextColor(matrix.Color333(1,2,3)); // 시계의 색상설정
  matrix.setTextSize(2);
  matrix.setCursor(8,0); // 시계를 띄울 좌표설정
  matrix.print(tempHour); // 서버에서 받아온 현재시간을 변수화시켜서 출력
  matrix.setCursor(32,0); // 시계를 띄울 좌표설정
  matrix.print(tempMin);
  matrix.setTextSize(1);
  matrix.setCursor(29,3);
  matrix.print('|');
  Serial.print("matrix watch => ");
  Serial.print(tempHour);
  Serial.print(" : ");
  Serial.println(tempMin);
  
}

void temp(String temp,String minT,String maxT){ // 현재온도 함수
  matrix.setTextColor(matrix.Color333(3,2,1)); // 온도색상설정
  matrix.setCursor(8,16); // 현재온도를 띄울 좌표설정
  matrix.print(temp);
  matrix.setCursor(25,16);
  matrix.print(minT+'/'+maxT); // 서버에서 받아온 현재온도를 변수화시켜서 출력
}

void loop() { // 아두이노 반복작업
  static boolean shiftOnOff=false;
  static boolean downOnOff = false;
  

  if(millis()-timeVal>=100){ //1초 단위 출력
    
     readTime +=(millis()-timeVal);
     timeVal = millis();

    shiftOnOff=leftShift(shiftOnOff);
    if(downOnOff){
      downOnOff = downPosition();
    }
     
     if(readTime>=86400000){
       Serial.println(readTime);
       readTime=0;
     }
    if((readTime/100)%10==0) { //초단위     
         Serial.println("1초 단위");
         showClock();
         cur_time_test();
         if((readTime/100)%200==0) {
          Serial.println("20초 단위");
          if(!shiftOnOff) shiftOnOff=true;
         }
         if((readTime/100)%100==0) {
          Serial.println("10초 단위");
          if(!downOnOff) downOnOff=true;
         }
        if((readTime/100)%3000==0) { //5분단위
           Serial.println("5분단위");
           setWeather();
           //setText=> 일정 정보 갱신시
        }else if((readTime/100)%600==0) { //1분단위
           Serial.println("1분단위");
           char ch = Serial.read();
           if (ch=='1')
              {
                matrixText[1] = "hello";
              }
           setWeather();
          
        } 
        ////////////////////////////////
        
        ///////////////////////
     }
    
  }

  // Update display
  matrix.swapBuffers(false);
}
