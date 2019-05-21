var fs = require('fs');
var readline = require('readline');
var net = require('net');
var {google} = require('googleapis');
//var googleAuth = require('google-auth-library');
var moment=require('moment');
// If modifying these scopes, delete token.json.
var SCOPES = ['https://www.googleapis.com/auth/calendar.readonly',
                'https://www.googleapis.com/auth/calendar'
                ];

var TOKEN_PATH = 'token2.json';

// requestGoogle('delete','google2',
//               moment('201905202000','YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00'),
//               moment('201905202100','YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00')).then(function(data) {
//                 console.log(data);
//               });
// var dataStr = String(text).split('_');
// requestGoogle(dataStr[1],dataStr[2],
//               moment(dataStr[3],'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00'),
//               moment(dataStr[4],'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00')
//             );
//console.log( moment(new Date()).format('YYYY-MM-DDTHH:mm:SS+09:00'));
//requestGoogle('list', moment(new Date()).format('YYYY-MM-DDTHH:mm:SS+09:00'));
function requestGoogle(command) {
  var arr = [];
  arr.push(arguments[1]);
  arr.push(arguments[2]);
  arr.push(arguments[3]);
  return new Promise(function(resolve,reject) {

    fs.readFile('client_secret.json', function(err, content)  {
      if (err) return reject('====request err====='+err);
      // Authorize a client with credentials, then call the Google Calendar API.
      if(command == 'list') {
        authorize(JSON.parse(content), listEvents,arr[0],arr[1]).then(function(data) {
          resolve(data);
        });
      } else if(command == 'insert') {
        authorize(JSON.parse(content), insertEvents,arr[0],arr[1],arr[2]).then(function(data) {
          resolve(data);
        });
      } else if(command == 'delete') {
        authorize(JSON.parse(content), deleteEvents,arr[0],arr[1],arr[2]).then(function(data) {
          resolve(data);
        });
      }
    });

});

}

function authorize(credentials, callback) {
  var arr = [];
  arr.push(arguments[2]);
  arr.push(arguments[3]);
  arr.push(arguments[4]);

  return new Promise(function(resolve,reject) {

  var {client_secret, client_id, redirect_uris} = credentials.installed;
  var oAuth2Client = new google.auth.OAuth2(client_id, client_secret, redirect_uris[0]);

  // Check if we have previously stored a token.
  fs.readFile(TOKEN_PATH, function(err, token) {
    if (err) return getAccessToken(oAuth2Client, callback);
    oAuth2Client.setCredentials(JSON.parse(token));
    if(callback==listEvents) {
      callback(oAuth2Client,arr[0],arr[1]).then(function(data) {
        resolve(data);
      });
    }
    else if(callback==insertEvents) {
      callback(oAuth2Client,arr[0],arr[1],arr[2]).then(function(data) {
        resolve(data);
      });
    }
    else if(callback==deleteEvents) {
      callback(oAuth2Client,arr[0],arr[1],arr[2]).then(function(data) {
        resolve(data);
      });
    }
    });
  });
}


function getAccessToken(oAuth2Client, callback) {
  //인증 절차 추가 필요
  var arr = [];
  arr.push(arguments[2]);
  arr.push(arguments[3]);
  arr.push(arguments[4]);
  return new Promise(function(resolve,reject) {
  var authUrl = oAuth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: SCOPES,
  });
  console.log('Authorize this app by visiting this url:', authUrl);
  var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });
  rl.question('Enter the code from that page here: ', function(code)  {
    rl.close();
    oAuth2Client.getToken(code, function(err, token) {
      if (err) return reject('====getAccessToken err====='+err);
      oAuth2Client.setCredentials(token);
      // Store the token to disk for later program executions
      fs.writeFile(TOKEN_PATH, JSON.stringify(token), function(err) {
        if (err) return reject('====writeFile err====='+err);
        console.log('Token stored to', TOKEN_PATH);
      });
      if(callback==listEvents) {
        callback(oAuth2Client,arr[0],arr[1]).then(function(data) {
          resolve(data);
        });
      }
      else if(callback==insertEvents) {
        callback(oAuth2Client,arr[0],arr[1],arr[2]).then(function(data) {
          resolve(data);
        });
      }
      else if(callback==deleteEvents) {
        callback(oAuth2Client,arr[0],arr[1],arr[2]).then(function(data) {
          resolve(data);
        });
      }
    });
  });
  });
}

/**
 * Lists the next 10 events on the user's primary calendar.
 * @param {google.auth.OAuth2} auth An authorized OAuth2 client.
 */
function listEvents(auth,start_t,end_t) {
  return new Promise(function(resolve,reject) {
  list='';
  var calendar = google.calendar({version: 'v3', auth});
  //console.log('now : '+now);
  calendar.events.list({
    calendarId: 'primary',
    timeMin:start_t,
    timeMax:end_t,
    singleEvents: true,
    orderBy: 'startTime',
  }, function(err, res) {
    if (err) return reject('====list err====='+err);
    var events = res.data.items;
    console.log(new Date());
    if (events.length) {
      console.log('Upcoming 10 events:');
      events.map(function(event, i)  {
        var start = event.start.dateTime || event.start.date;
        var end = event.end.dateTime || event.end.date;
        list+=('_'+start+'_'+end+'_'+ event.summary+'/');
        console.log('%s - %s ', start, event.summary);
      });
      resolve(list);
    } else {
      console.log('No upcoming events found.');
    }
  });
  });
}
function deleteEvents(auth,text,start,end) {
  return new Promise(function(resolve,reject) {
  const calendar = google.calendar({version: 'v3', auth});
  calendar.events.list({
    calendarId: 'primary',
    timeMin:start,
    timeMax:end,
    singleEvents: true,
    orderBy: 'startTime',
  }, function(err, res) {
    if (err) return reject('====delete err====='+err);
    const events = res.data.items;
    if (events.length) {
      events.map((event, i) => {
        console.log(event.summary+event.id);
        if(event.summary == text) {
          calendar.events.delete({
            calendarId: 'primary',
            eventId:event.id
          },function(err,res){
            if(err) return reject('====delete err====='+err);
            resolve('delete'+res.toString());

          });
        }
      });
    } else {
      console.log('No upcoming events found.');
    }
  });
  });

}
function insertEvents(auth,text,t_start,t_end) {
  return new Promise(function(resolve,reject) {
  var calendar = google.calendar({version: 'v3', auth});
  var event = {
   summary: text,
   start: {
     dateTime: t_start,
   },
   end: {
     dateTime:t_end,
   }
 };
  calendar.events.insert({
    calendarId : 'primary',
    resource : event
  },function(err,res){
    if(err) return reject('====insert err====='+err);
    resolve('test create');

  });
});
}

var server = net.createServer(function(socket) {
  //서버를 생성
  console.log(socket.address().address+'connected');


  // socket.connect(function(){
  //   console.log('connect');
  // });
  socket.on('data',function(data) {
    //client로부터 받아온 데이터를 출력
    console.log("Android connect");
    console.log('rcv : '+data);
    if(String(data).indexOf('Android')!=-1) { // Android_insert_go to movie_201905231800_201905232000
      //var testVar = "Android_insert_go to movie with friends_201905231100_201905231300_";
      var dataStr = String(data).split('_');
      // var start_t = moment(dataStr[3],'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:00+09:00');
      // var end_t= moment(dataStr[4],'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:00+09:00');
      // console.log(start_t);
      // console.log(end_t);

      if(dataStr[1]=='ouath') {
        //getAccessToken
      } else if(dataStr[1]=='list') {
        //list_yesr_month
        //var lastDay = new Date(dataStr[2],dataStr[3],0).getDate();
        console.log(moment(dataStr[2],'YYYYMMDDHHmm').format('YYYY-MM-DDT00:00:00+09:00'));
        console.log(moment(dataStr[3],'YYYYMMDDHHmm').format('YYYY-MM-DDT23:59:59+09:00'));
        requestGoogle('list', moment(dataStr[2],'YYYYMMDDHHmm').format('YYYY-MM-01T00:00:00+09:00'),
                              moment(dataStr[3],'YYYYMMDDHHmm').format('YYYY-MM-DDT23:59:59+09:00'))
                              .then(function(data) {
                                  socket.write(data);
                                    console.log(data);
                                    socket.destroy();
                                    }
                                  );

      } else if(dataStr[1]=='insert') {
        requestGoogle(dataStr[1],dataStr[2],
                      moment(dataStr[3],'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00'),
                      moment(dataStr[4],'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00')
                    ).then(function(data) {
                      socket.write(data);
                      console.log(data);
                      socket.destroy();
                    });

      } else if(dataStr[1]=='delete') {
        //var summaryText=data.slice();
        //var startText=data.slice();
        //var endText=data.slice();

        requestGoogle(dataStr[1],dataStr[2],
                      moment(dataStr[3],'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00'),
                      moment(dataStr[4],'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00')
                    ).then(function(data) {
                      socket.write(data);
                      console.log(data);
                      socket.destroy();
                    });

      } else if(dataStr[1]=='weather') {
        socket.write('weather');
      }
      //socket.destroy();
    } else if(String(data).indexOf('Arduino')!=-1) {
      console.log("Arduino connect");
      Send().then(function(sendStr){
        socket.write(sendStr);
        console.log(data);
        socket.destroy();
      });
    }else {
      Send().then(function(sendStr){
        console.log('not data');
        socket.write('not');
        socket.destroy();
      });
    }
  });

  socket.on('close',function() {
    socket.destroy();
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
