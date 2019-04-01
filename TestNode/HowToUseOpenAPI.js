var request = require('request');

var url = 'http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/';
var timeDataUrl = 'ForecastTimeData'; //예보실황
var spaceDataUrl = 'ForecastSpaceData'; //동네예보
var serviceKey = 'iXV4vLvb8wkopH3ekhwxmhhcI0033T3I3aciC7tz%2FYH9K0G0xmDsoGL7zO%2FQHyQ0Del7YotVrbI7p2ndjgZH4w%3D%3D';
var nx = '60';
var ny = '127';
var base_date = '20190326';
var base_time = '0200';
var _type = 'json';
var numOfRows_S = 155; // spaceData
var numOfRows_T = 30; //timeData


//동네예보 querySpaceData
function queryMaker(data,numOfRows) {
  var queryP = data + '?' + 'ServiceKey=' + serviceKey;
  queryP += '&nx='+nx;
  queryP += '&ny='+ny;
  queryP += '&base_date='+base_date;
  queryP += '&base_time='+base_time;
  queryP += '&_type='+_type;
  queryP += '&numOfRows='+numOfRows;

  /*
  var queryParams = '?' + encodeURIComponent('ServiceKey') + '=서비스키'; //Service Key
  queryParams += '&' + encodeURIComponent('ServiceKey') + '=' + encodeURIComponent('TEST_SERVICE_KEY'); // 서비스 인증
  queryParams += '&' + encodeURIComponent('ftype') + '=' + encodeURIComponent('VSRT'); // 파일구분 -ODAM: 동네예보실황 -VSRT: 동네예보초단기 -SHRT: 동네예보단기
  queryParams += '&' + encodeURIComponent('basedatetime') + '=' + encodeURIComponent('2015112030800'); // 각각의 base_time 로 검색 참고자료 참조
  */

  //console.log(queryParams);

  return queryP;
}
function weatherRequest(data,row) {
  var dir=0;
  var i=0;
  if(row === 155) {
    dir = 0;
  } else {
    dir = 1;
  }
  request({
      url: url + data,
      method: 'GET'
  }, function (error, response, body) {
    if(!error&&response.statusCode==200) {
      var j_body = JSON.parse(body);
      switch(dir) {
        case 0:
        for( i =0;i<numOfRows_S;i++) {
          //console.log(dir);
          if(j_body.response.body.items.item[i].category==='POP' ) {
              console.log('pop'+j_body.response.body.items.item[i].fcstDate+','+j_body.response.body.items.item[i].fcstTime+' : '+j_body.response.body.items.item[i].fcstValue);
          } //동네 예보 02시 갱), 강수확률
          else if(j_body.response.body.items.item[i].category==='TMN') {
            console.log('tmn'+j_body.response.body.items.item[i].fcstDate+','+j_body.response.body.items.item[i].fcstTime+' : '+j_body.response.body.items.item[i].fcstValue);
          } //동네 예보, 최고 온도
          else if(j_body.response.body.items.item[i].category==='TMX') {

            console.log('tmx'+j_body.response.body.items.item[i].fcstDate+','+j_body.response.body.items.item[i].fcstTime+' : '+j_body.response.body.items.item[i].fcstValue);
          } //동네 예보, 최저 온도

        }
          break;
        case 1:
        for(i =0;i<numOfRows_T;i++) {
          //console.log(dir);
          if(j_body.response.body.items.item[i].category==='T1H' ) {
              console.log('t1h'+j_body.response.body.items.item[i].fcstDate+','+j_body.response.body.items.item[i].fcstTime+' : '+j_body.response.body.items.item[i].fcstValue);
          } //초단기예보, 현재온도
          else if(j_body.response.body.items.item[i].category==='PTY') {
            console.log('pty'+j_body.response.body.items.item[i].fcstDate+','+j_body.response.body.items.item[i].fcstTime+' : '+j_body.response.body.items.item[i].fcstValue);
          } //초단기예보, 강수 형태
          else if(j_body.response.body.items.item[i].category==='SKY') {
            console.log('sky'+j_body.response.body.items.item[i].fcstDate+','+j_body.response.body.items.item[i].fcstTime+' : '+j_body.response.body.items.item[i].fcstValue);
          } //동초단기예보, 하늘 상태
        }
          break;
        default:
          console.log(error);
          break;
      }



    }
      //console.log('Status', response.statusCode);
      //console.log('Headers', JSON.stringify(response.headers));
      //console.log('Reponse received', body);
  });
}
spaceDataUrl = queryMaker(spaceDataUrl,numOfRows_S); //24시간 주기
//console.log(spaceDataUrl);
weatherRequest(spaceDataUrl,numOfRows_S);

timeDataUrl = queryMaker(timeDataUrl,numOfRows_T); //3시간 주기
//console.log(timeDataUrl);
weatherRequest(timeDataUrl,numOfRows_T);


/*
var queryParams = '?' + encodeURIComponent('ServiceKey') + '=서비스키'; //Service Key
queryParams += '&' + encodeURIComponent('ServiceKey') + '=' + encodeURIComponent('TEST_SERVICE_KEY'); // 서비스 인증
queryParams += '&' + encodeURIComponent('ftype') + '=' + encodeURIComponent('VSRT'); // 파일구분 -ODAM: 동네예보실황 -VSRT: 동네예보초단기 -SHRT: 동네예보단기
queryParams += '&' + encodeURIComponent('basedatetime') + '=' + encodeURIComponent('2015112030800'); // 각각의 base_time 로 검색 참고자료 참조
*/

//console.log(queryParams);
