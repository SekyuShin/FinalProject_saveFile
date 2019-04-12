const cron = require('node-cron');
const request = require('request');
var express = require('express');
const url = 'http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/';
const timeDataUrl = 'ForecastTimeData'; //예보실황
const spaceDataUrl = 'ForecastSpaceData'; //동네예보
const serviceKey = 'iXV4vLvb8wkopH3ekhwxmhhcI0033T3I3aciC7tz%2FYH9K0G0xmDsoGL7zO%2FQHyQ0Del7YotVrbI7p2ndjgZH4w%3D%3D';

var nx = '59'; //+)추가할까
var ny = '123';
//var base_date = '20190402';
//var base_time = '0200';
var cur_time;
var cur_date;

var pop,tmn,tmx,sky,t1h,pty;
var sendStr;


const _type = 'json';
const numOfRows_S = 40; // spaceData
const numOfRows_T = 20; //timeData
var list = [];
function sendMaker() {
  //var str = (new Date()+'\n'+pop.fcstTime+','+pop.fcstValue+'/'+tmx.fcstValue+'/'+tmn.fcstValue+'/\n'+pty.baseTime+':'+pty.fcstValue+'/'+sky.fcstValue+'/'+t1h.fcstValue);
  var str = pop + tmn + tmx + sky + t1h + pty;
  return str;
}

function presentTime() {
  return new Promise((resolve, reject) => {
    const d = new Date();
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

  var queryP = data + '?' + 'ServiceKey=' + serviceKey;
  queryP += '&nx='+nx;
  queryP += '&ny='+ny;
  queryP += '&base_date='+base_date;
  queryP += '&base_time='+base_time;
  queryP += '&_type='+_type;
  queryP += '&numOfRows='+numOfRows;

  return queryP;

}
function popParsing(j_body) {
  var popMax = j_body.fcstValue;
}
function spaceParsing(j_body) {
  var popMax=-1, pop_body;
  var len;
  presentTime();
  console.log(j_body);
  if (j_body.response.header.resultCode != '0000') {
    return ;
  }
  if(j_body.response.body.totalCount>=40){
    len = 40;
  } else {
    len = j_body.response.body.totalCount;
  }

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

      console.log(j_body.response.body.items.item[i]);
    }

  }
  pop = pop_body;
  //console.log(pop);

}
function t_basicParsing(j_body) {
  var temp = Math.floor((j_body.fcstTime)/100)-Math.floor(j_body.baseTime/100);
  if(temp === 1 || Math.abs(temp) === 23) {
    return 1;
  } else {
    return 0;
  }
}

async function timeParsing(j_body) {
  var temp;
  var len;
  console.log(j_body);
  if (j_body.response.header.resultCode != '0000') {
    return ;
  }
  if(j_body.response.body.totalCount>=20){
    len = 20;
  } else {
    len = j_body.response.body.totalCount;
  }
  for(var i =0;i<len;i++) {
    if(j_body.response.body.items.item[i].category === 'T1H') {
      if(t_basicParsing(j_body.response.body.items.item[i])) {
        t1h = j_body.response.body.items.item[i];
        //console.log(t1h);
      }
      //console.log('t1h');
    } else if(j_body.response.body.items.item[i].category === 'SKY') {
      if(t_basicParsing(j_body.response.body.items.item[i])) {
        sky = j_body.response.body.items.item[i];
        //console.log(sky);
      }
      //console.log('sky');
    } else if(j_body.response.body.items.item[i].category === 'PTY') {
      if(t_basicParsing(j_body.response.body.items.item[i])) {
        pty = j_body.response.body.items.item[i];
        //console.log(pty);
      }
      //console.log('pty');
    }


  }

}

function weatherRequest(dataUrl,date,time) {
  return new Promise((resolve, reject) => {
    var j_body;
    var dir;
    if(dataUrl === 'ForecastSpaceData') {
      dataUrl = queryMaker(dataUrl,numOfRows_S,date,time);
      dir = 0;
    } else if(dataUrl === 'ForecastTimeData') {
      dataUrl = queryMaker(dataUrl,numOfRows_T,date,time);
      dir = 1;
    } else {
      console.log('url error');
    }

    request({
        url: url + dataUrl,
        method: 'GET'
    }, function (error, response, body) {
      if(!error&&response.statusCode==200) {
        console.log(url+dataUrl);
        j_body = JSON.parse(body);
        if(dir === 0) { //space
          spaceParsing(j_body);
        } else if(dir === 1) { //time
          timeParsing(j_body);
        }
        resolve();
        }
    });
  })
}
function show () {
  return new Promise((resolve, reject) => {
    console.log(pop,tmx,tmn,pty,sky,t1h);
    //console.log('cur_time'+(cur_time.slice(-2)-1+'45'));
    sendStr= sendMaker();
    console.log('sendStr = ',sendStr);
    list.push(sendStr);
    resolve();
  });
}
//반복될 스케줄러 함수
function Cron_Scheduler(date_str,dataUrl) {
  var b_time;

  cron.schedule(date_str, function () {
      now = new Date();
      console.log(now);
      if(dataUrl === timeDataUrl) {
          presentTime();
          b_time = cur_time.slice(0,2)+'00';
      }else if(dataUrl === spaceDataUrl) {
        presentTime();
        b_time = cur_time.slice(0,2)+'30';
      }
      weatherRequest(dataUrl,cur_date,b_time);
      show();
      //console.log(`${date_str}: `,year,month,day,hour,minutes);
  }).start();
}
async function  main(){//socket) {
  var time;
  var date;
  await presentTime();
  console.log(new Date());
  time = cur_time;
  if(time>='0000' && time<'0210') {
    date=cur_date-1;
    console.log('date : ',date);
  } else {
    date = cur_date;
  }
  await weatherRequest(spaceDataUrl,date,'0200');
  await weatherRequest(spaceDataUrl,date,(time.slice(0,2))+'00');
  if(time.slice(-2)<45) {
    time=(time.slice(0,2)-1)+'30';
  } else {
    time = time.slice(0,2)+'30';
  }
  await weatherRequest(timeDataUrl,cur_date,time);


  show();
  //socket.write(''+sendMaker());
  Cron_Scheduler('46 */1 * * *',timeDataUrl); // 단기 예보
  Cron_Scheduler('11 2,5,8,11,17,20,23 * * *',spaceDataUrl); // 동네 예보

}


main();
var http = express();

http.get('/', function (req, res) {
  res.send(list);
});

http.listen(3000, function() {
  console.log('Start Server:3000');
});
