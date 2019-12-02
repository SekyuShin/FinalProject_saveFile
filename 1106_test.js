
var net = require('net');



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
    if(String(data).indexOf('Arduino')!=-1) {
      var arduinoData='';

      arduinoData+=moment().format('HH:mm:ss');
      arduinoData+='_1800:20_16_6_-_m-cloudy_16&1_201911061500_201911061600_nonono';
          socket.write(arduinoData);
          socket.destroy();


    }else {
      Send().then(function(sendStr){
        console.log('not data');
        socket.write('not');
        socket.destroy();

      });
    }
  });

  socket.on('close',function() {
    //socket.destroy();
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
/*
var http = express();

http.get('/', function (req, res) {
  res.send(list);
});

http.listen(3000, function() {
  console.log('Start Server:3000');
});
*/
