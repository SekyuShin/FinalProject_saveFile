/**
 * @example TCPClientSingle.ino
 * @brief The TCPClientSingle demo of library WeeESP8266. 
 * @author Wu Pengfei<pengfei.wu@itead.cc> 
 * @date 2015.02
 * 
 * @par Copyright:
 * Copyright (c) 2015 ITEAD Intelligent Systems Co., Ltd. \n\n
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version. \n\n
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include "ESP8266.h"
#define SSID        "Sekyu"
#define PASSWORD    "tlstprb1191"
#define HOST_NAME   "172.16.110.102"
#define HOST_PORT   3000
String data;
ESP8266 wifi(Serial3,115200);
void setup(void)
{
    Serial.begin(115200);
    Serial.print("setup begin\r\n");

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
  
    while(!wifi.joinAP(SSID, PASSWORD)) {
        Serial.print(".");
    }
    Serial.print("IP:");
    Serial.println( wifi.getLocalIP().c_str()); 
    Serial.print("setup end\r\n");
}
void tcpInterface(boolean scheduleOnoff) {
  char buffer[1024] = {0};
  while(!wifi.joinAP(SSID, PASSWORD)) Serial.print(".");
  while(!wifi.createTCP(HOST_NAME, HOST_PORT))Serial.print(".");
  if(scheduleOnoff) {
    char* str = "Arduino schedule\n";
    wifi.send((const uint8_t*)str, strlen(str));
    wifi.recv(buffer, sizeof(buffer), 10000);
    data=buffer;
    Serial.println(data);
         
//   parsingStr();
//   parsingClock(toStringData(&REALTIME));
//   ShowParsingData(); //삭제예정
//   ledControl();
   
  } else {
   char* str = "Arduino\n";
    wifi.send((const uint8_t*)str, strlen(str));
    wifi.recv(buffer, sizeof(buffer), 10000);
    data=buffer;
    Serial.println(data);

//   parsingStr();
//   parsingClock(toStringData(&REALTIME));
//   ShowParsingData(); //삭제예정
  }
   
}
void loop(void)
{
    tcpInterface(true);
    delay(5000);
    tcpInterface(false);
    delay(5000);
}
