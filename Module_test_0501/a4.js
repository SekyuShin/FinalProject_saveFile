var moment = require('moment');
var net = require('net');

var start = "2019-06-08T13:47:34+09:00";
var end = "2019-06-09T01:47:34+09:00";


console.log(moment(start,'YYYY-MM-DDTHH:mm:SS+09:00').format("YYYYMMDDHHmm"));
console.log(moment(end,'YYYY-MM-DDTHH:mm:SS+09:00').format("YYYYMMDDHHmm"));
var str = "15:14:51_0300:30_26_16_-_m-cloudy_26&!?";
//var str = "15:14:51_0300:30_26_16_-_m-cloudy_26&1_2_3_test";
var server = net.createServer(function(socket) {
  //서버를 생성
  console.log(socket.address().address+'connected');
  // socket.connect(function(){
  //   console.log('connect');
  // });
  socket.on('data',function(data) {
    console.log(data);
    socket.write(str);
    socket.destroy();
  });

  socket.on('close',function() {
    //socket.destroy();
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
/*
var http = express();

http.get('/', function (req, res) {
  res.send(list);
});

http.listen(3000, function() {
  console.log('Start Server:3000');
});
*/
