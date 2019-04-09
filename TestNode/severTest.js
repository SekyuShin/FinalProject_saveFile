var net = require('net');
var cron = require('node-cron');
var a='0';
function test() {
  setTimeout(function() {
  console.log('Works! 1 ');
    a='1';
}, 3000);
    console.log(1);


}
function test2(socket) {
socket.write('2');

}
var server = net.createServer(function(socket) {
  //서버를 생성
  console.log(socket.address().address+'connected');
  console.log('connection');
  socket.on('data',function(data) {
    //client로부터 받아온 데이터를 출력
    console.log('rcv : '+data);
  });

test2(socket);


  socket.on('close',function() {
    //접속이 끊길때 메세지 출력
    console.log('client disconnected');
  });
  socket.write('welcome to server');
  //접속시 메세지 출력
});

server.on('error',function(err) {
  //에러시 메세지 출력
  console.log('err'+err);
});
server.on('close',function() {
  //접속이 끊길때 메세지 출력
  console.log('client disconnected');
});
server.listen(5000,function() {
  //접속 가능할때까지 대기
  console.log('linsteing on 5000..');
});


//https://ourcstory.tistory.com/67
