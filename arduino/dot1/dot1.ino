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

unsigned long timeVal; //이전시간
unsigned long readTime;

/*
 * downShift 10초마다 시작
 * 시간 가운데 깜박임
 * 날씨 정보 set
 * 구름 지워지지 말게 (비올때 갱신)
 */


void setup() { // 아두이노를 원활하게 실행하기 위한 사전설정
  matrix.begin();
  Serial.begin(115200); // 시리얼통신(11520000hz)
  matrix.setTextWrap(false); //도트매트릭스를 화면 엣지(끝부분)까지 킬 수있도록 함
  matrix.setTextSize(1); // 매트릭스 글자크기설정(기본값 1)
  timeVal = millis();
}

boolean downPosition(boolean onOff) { // 도트매트릭스에 눈이나 비가 오는 기능을 구현하기 위한 함수
static XY location[8]; // 위 기능을 위해 XY좌표를 배열로 선언

  for(int i =0;i<8;i++) { 
    if(location[i].y >39){ 
       location[i].y = random(-10,0);  // 비나 눈효과를 좀 더 극적으로 주기 위해 
       location[i].x = random(-5,5);   // 랜덤으로 X,Y를 설정함
       //Serial.println(location[i].x,DEC);  
       if(location[i].x <0) {
        (location[i].x)+=32; 
       }
    }else {
      location[i].y++;
      
    }
    if(location[i].y>3) Rain(location[i].x,location[i].y); // 기상효과(비) 함수호출
   // if(location[i].y>3) Snow(location[i].x,location[i].y); // 기상효과(눈) 함수호출
   
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

void Cloud(int x, int y) { // 기상효과(구름) 함수
  matrix.fillCircle(x,y,2,matrix.Color333(1,1,1)); // 구름이 뭉쳐있는 효과를 내기 위하여 흰색
  matrix.fillCircle(x+3,y-2,2,matrix.Color333(1,1,1)); // 원을 연이어 그려서 효과를 낸다.
  matrix.fillCircle(x+5,y,2,matrix.Color333(1,1,1));  
}

void Sun(int x, int y){ // 기상효과(맑음 또는 해) 함수
  matrix.fillCircle(x,y,2,matrix.Color333(1,1,0)); 
  matrix.drawLine(x,y+4,x,y+6,matrix.Color333(1,1,0)); // 위아래세로
  matrix.drawLine(x,y-4,x,y-6,matrix.Color333(1,1,0));
  matrix.drawLine(x+4,y,x+6,y,matrix.Color333(1,1,0)); // 좌우
  matrix.drawLine(x-4,y,x-6,y,matrix.Color333(1,1,0));
  matrix.drawLine(x+3,y+3,x+4,y+4,matrix.Color333(1,1,0));
  matrix.drawLine(x-3,y-3,x-4,y-4,matrix.Color333(1,1,0));
  matrix.drawLine(x+3,y-3,x+4,y-4,matrix.Color333(1,1,0));
  matrix.drawLine(x-3,y+3,x-4,y+4,matrix.Color333(1,1,0));
}

void watch(String hour,String minute){ // 시계함수
  matrix.setTextColor(matrix.Color333(1,2,3)); // 시계의 색상설정
  matrix.setTextSize(2);
  matrix.setCursor(8,0); // 시계를 띄울 좌표설정
  matrix.print(hour+minute); // 서버에서 받아온 현재시간을 변수화시켜서 출력
  matrix.setTextSize(1);
  matrix.setCursor(29,3); //////////////////////////////////////////////커서부분 // 초단위로 옮길예정
  matrix.print('|');
}

void temp(String temp,String minT,String maxT){ // 현재온도 함수
  matrix.setTextColor(matrix.Color333(3,2,1)); // 온도색상설정
  matrix.setCursor(12,16); // 현재온도를 띄울 좌표설정
  matrix.print(temp+' '+minT+'/'+maxT); // 서버에서 받아온 현재온도를 변수화시켜서 출력
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
           
        }else if((readTime/100)%600==0) { //1분단위
           Serial.println("1분단위");
           watch("12","30");
           temp("12","3","20");
           Cloud(2,4);
           Cloud(56,4);
          
        } 
        ////////////////////////////////
        
        ///////////////////////
     }
    
  }

  // Update display
  matrix.swapBuffers(false);
}
