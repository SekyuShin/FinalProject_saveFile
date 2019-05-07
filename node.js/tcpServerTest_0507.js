// function 정리
// 알고리즘 안정화
// 지속적인 결과 받기
// 04_13
// spaceData
var net = require('net');
const cron = require('node-cron');
const request = require('request');
var express = require('express');

const url = 'http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/';
const timeDataUrl = 'ForecastTimeData'; //예보실황
const spaceDataUrl = 'ForecastSpaceData'; //동네예보
const serviceKey = 'iXV4vLvb8wkopH3ekhwxmhhcI0033T3I3aciC7tz%2FYH9K0G0xmDsoGL7zO%2FQHyQ0Del7YotVrbI7p2ndjgZH4w%3D%3D';

var nx = '59'; //+)추가할까
var ny = '123';
var cur_time;
var cur_date;
//var list=[];
var pop,tmn,tmx,sky,t1h,pty;
var sendStr;

const _type = 'json';
const numOfRows_S = 40; // spaceData
const numOfRows_T = 20; //timeData

function presentTime() {
  return new Promise((resolve, reject) => {
    const d = new Date();
    console.log(d);
    const YYYY = d.getFullYear();
    const MM = ("00" + (d.getMonth() + 1)).slice(-2);
    const DD = ("00" + d.getDate()).slice(-2);
    cur_date = YYYY+MM+DD;
    const hh = ("00" + d.getHours()).slice(-2);
    const mm = ("00" + d.getMinutes()).slice(-2);
    cur_time = hh+mm;

    resolve();
  });
}
function queryMaker(data,numOfRows,base_date,base_time) {
  return new Promise((resolve,reject)=> {
    var queryP = data + '?' + 'ServiceKey=' + serviceKey;
    queryP += '&nx='+nx;
    queryP += '&ny='+ny;
    queryP += '&base_date='+base_date;
    queryP += '&base_time='+base_time;
    queryP += '&_type='+_type;
    queryP += '&numOfRows='+numOfRows;

    resolve(queryP);
  });

}
function spaceParsing(j_body,len) {
  return new Promise(async(resolve,reject) =>{
      var popMax=-1, pop_body;
      if(len >= 40){
        len = 40;
      }
      presentTime().then(()=>{
        console.log(j_body);

        for(var i =0;i<len;i++) {
          //console.log('test'+j_body.response.body.items.item[0].category);
          if(j_body.response.body.items.item[i].category === 'TMN'&&
                      (j_body.response.body.items.item[i].fcstDate).toString() === cur_date) {
            //console.log(j_body.response.body.items.item[i]);
            tmn = j_body.response.body.items.item[i];
            //console.log(tmn);
          } else if(j_body.response.body.items.item[i].category === 'TMX' &&
                      (j_body.response.body.items.item[i].fcstDate).toString() === cur_date) {
            //console.log(j_body.response.body.items.item[i]);
            tmx = j_body.response.body.items.item[i];
            //console.log(tmx);
          } else if(j_body.response.body.items.item[i].category === 'POP'&& popMax<j_body.response.body.items.item[i].fcstValue) {
              popMax = j_body.response.body.items.item[i].fcstValue;
              pop_body = j_body.response.body.items.item[i];
            //console.log(j_body.response.body.items.item[i]);
          }
        }
        pop = pop_body;
        //console.log(pop);

      resolve();
      });

  });




}
function t_basicParsing(j_body) { //1시간 후만 정보 파싱
  return new Promise(async(resolve,reject) =>{
    var temp = Math.floor((j_body.fcstTime)/100)-Math.floor(j_body.baseTime/100);
    if(temp === 1 || Math.abs(temp) === 23) {
      resolve(1);
    } else {
      resolve(0);
    }

  });

}
function timeParsing(j_body,len) {
  return new Promise(async(resolve,reject) =>{
    var temp;
    console.log(j_body);
    for(var i =0;i<len;i++) {
      if(j_body.response.body.items.item[i].category === 'T1H') {
        if(await t_basicParsing(j_body.response.body.items.item[i])) {
          t1h = j_body.response.body.items.item[i];
          //console.log(t1h);
        }
        //console.log('t1h');
      } else if(j_body.response.body.items.item[i].category === 'SKY') {
        if(await t_basicParsing(j_body.response.body.items.item[i])) {
          sky = j_body.response.body.items.item[i];
          //console.log(sky);
        }
        //console.log('sky');
      } else if(j_body.response.body.items.item[i].category === 'PTY') {
        if(await t_basicParsing(j_body.response.body.items.item[i])) {
          pty = j_body.response.body.items.item[i];
          //console.log(pty);
        }
        //console.log('pty');
      }
    }
    resolve();
  });


}
function getRowLen(dataUrl,date,time) {
  return new Promise(async(resolve, reject) => {
    var j_body;
    dataUrl = queryMaker(dataUrl,10,date,time).then(async(dataUrl) =>{
      console.log(url+dataUrl);
      request({
          url: url + dataUrl,
          method: 'GET'
      }, function (error, response, body) {
        if(!error&&response.statusCode==200) {
          j_body = JSON.parse(body);
          if (j_body.response.header.resultCode === '0000') {
            resolve(j_body.response.body.totalCount);
          } else {
            console.log('error : '+j_body.response.header.resultMsg);
            reject('error');
          }

          }
      });
    }) ;

  })
}
function weatherRequest(dataUrl,date,time) {
  return new Promise(async(resolve, reject) => {
    var j_body;
    await getRowLen(dataUrl,date,time).then(async(len)=>{
      console.log(len);
      if(len === -1) {
        console.log('error : len');
        return -1;
      }
      await queryMaker(dataUrl,len,date,time).then(async(dataUrl)=>{
        request({
            url: url + dataUrl,
            method: 'GET'
        }, await function (error, response, body) {
          if(!error&&response.statusCode==200) {
            //console.log(url+dataUrl);
            j_body = JSON.parse(body);
            dataUrl = dataUrl.slice(8,9);
            if(dataUrl === 'S') { //space
              spaceParsing(j_body,len).then(function() {
                console.log(pop,tmx,tmn);
                  resolve();
              });
            } else if(dataUrl === 'T') { //time

              timeParsing(j_body,len).then(function() {
                console.log(pty,sky,t1h);
                  resolve();
              })
            }
            }
        });
      });

    });


  });
}
function init() {
  return new Promise(async (resolve,reject) => {
    var url_basetime;
    var url_basedate;

    await presentTime();
    url_basetime = cur_time;
    url_basedate = cur_date;
    if(url_basetime>='2311' || url_basetime<'0211') { // 현재시간이 spaceData 공백시간 일때
      if(url_basetime >='0000') {
        url_basedate-='1';
      }
      url_basetime = '2300';
      await weatherRequest(spaceDataUrl,url_basedate,url_basetime); //TMN, TMX,POP가져오기

    } else {
      url_basetime = '0200';
      await weatherRequest(spaceDataUrl,url_basedate,url_basetime); //TMN, TMX,POP가져오기

      url_basetime = cur_time;
      if(url_basetime.slice(0,2)%3===2) {
        if(url_basetime.slice(-2)<=11) {
          url_basetime = ('00'+(url_basetime.slice(0,2)-'3')).slice(-2) + '00';
        }else {
          url_basetime = ('00'+url_basetime.slice(0,2)).slice(-2) + '00';
        }
      } else if(url_basetime.slice(0,2)%3===1) {
        url_basetime = ('00'+(url_basetime.slice(0,2)-'2')).slice(-2) + '00';
      } else {
        url_basetime = ('00'+(url_basetime.slice(0,2)-'1')).slice(-2) + '00';
      }
      await weatherRequest(spaceDataUrl,url_basedate,url_basetime); //pop   POP가져오기
    }

    url_basetime = cur_time;
    url_basedate = cur_date;
    if(url_basetime<'0046') {
      url_basedate-='1';
      url_basetime = '2330';
    } else {
      if(url_basetime.slice(-2)<46) {
        url_basetime=('00'+(url_basetime.slice(0,2)-1)).slice(-2)+'30';
      } else {
        url_basetime =('00'+ url_basetime.slice(0,2)).slice(-2)+'30';
      }
    }
      await weatherRequest(timeDataUrl,url_basedate,url_basetime);

      resolve('init end');
  })
}
function Send() {
  return new Promise(async(resolve, reject) => {
    //console.log(pop,tmx,tmn,pty,sky,t1h);
    //console.log('cur_time'+(cur_time.slice(-2)-1+'45'));

    console.log('====================send==========================');
    sendStr= await sendMaker();
    console.log('sendStr = ',sendStr);

    //list.push(sendStr);
    resolve(sendStr);

  });
}
function sendMaker() {
  return new Promise(async(resolve,reject) =>{
    var str=''; //= (cur_date+cur_time+'\n'+pop.fcstTime+','+pop.fcstValue+'/'+tmx.fcstValue+'/'+tmn.fcstValue+'/\n'+pty.baseTime+':'+pty.fcstValue+'/'+sky.fcstValue+'/'+t1h.fcstValue);
    //  var str = pop + tmn + tmx + sky + t1h + pty;
    //pop = 강수 확률, 강수 시간대 포함
    // tmx,tmn 최저 최고 기온
    // pty 강수형태 0:없음, 1:비, 2:비/눈, 3:눈, 4:소나기
    // sky 하늘 상태  1:맑음, 3:구름 많음, 4:흐림 (2.삭제 2019.06)
    // t1h 현재 기온
    str+='/'+pop.fcstTime+':'+pop.fcstValue;
    str+=','+tmx.fcstValue;
    str+=','+tmn.fcstValue;
    switch(pty.fcstValue) {
      case 0:
        str+='/-';
        break;
      case 1:
        str+='/rain';
        break;
      case 2:
        str+='/sleet';
        break;
      case 3:
        str+='/snow';
        break;
      case 4:
        str+='/shower';
        break;
      default:
        str+='/=pe=';
        break;
    }
    switch(sky.fcstValue) {
      case 1:
        str+=',clear';
        break;
      case 2:
        str+=',s_cloud'; //삭제 예정
        break;
      case 3:
        str+=',cloud';
        break;
      case 4:
        str+=',m_cloudy';
        break;
      default:
        str+=',=se=';
        break;
    }
    str+=','+t1h.fcstValue;
    console.log('sendMaker = ',str);
    resolve(str+'\n');
  });

}
function Cron_Scheduler(date_str,dataUrl) {
  return new Promise((resolve,reject)=>{
    cron.schedule(date_str, async function () {

        await presentTime().then(async()=>{
          var b_time;
          if(dataUrl === timeDataUrl) {
            b_time = cur_time.slice(0,2)+'00';
          }else if(dataUrl === spaceDataUrl) {
            b_time = cur_time.slice(0,2)+'30';
          }
          await weatherRequest(dataUrl,cur_date,b_time).then(()=> {
            resolve();
          });
          sendMaker();
          //await Send();
          //console.log(`${date_str}: `,year,month,day,hour,minutes);
        });

    }).start();
  });


}
function  main(){

  init().then((data)=>{
    console.log('init state = ',data);
    sendMaker();
  });

  //socket.write(''+sendMaker());
  Cron_Scheduler('46 */1 * * *',timeDataUrl); // 단기 예보
  Cron_Scheduler('11 2,5,8,11,17,20,23 * * *',spaceDataUrl); // 동네 예보

}


main();

var server = net.createServer(function(socket) {
  //서버를 생성
  console.log(socket.address().address+'connected');


  // socket.connect(function(){
  //   console.log('connect');
  // });
  socket.on('data',function(data) {
    //client로부터 받아온 데이터를 출력
    console.log('rcv : '+data);
    if(String(data).indexOf('Android')) {
      console.log("Android connect");
      Send().then(function(sendStr){
        socket.write(sendStr);
      });
    } else if(String(data).indexOf('Arduino')) {
      console.log("Arduino connect");
      Send().then(function(sendStr){
        socket.write(sendStr);
      });
    }
  });

  socket.on('close',function() {
    console.log('client close');
  });
  //socket.write('welcome to server');
  //접속시 메세지 출력
});

server.on('error',function(err) {
  //에러시 메세지 출력
  console.log('err' + err);
});



server.listen(3000,function() {
  //접속 가능할때까지 대기
  console.log('linsteing on 3000..');
});

// var http = express();
//
// http.get('/', function (req, res) {
//   res.send(list);
// });
//
// http.listen(3000, function() {
//   console.log('Start Server:3000');
// });
