var net = require('net');
var cron = require('node-cron');
var cur_date,cur_time;
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
    const ss = ("00" + d.getSeconds()).slice(-2);
    cur_time = hh+mm+ss;

    resolve();
  });
}


var server = net.createServer(function(socket) {
  //서버를 생성
  console.log(socket.address().address+'connected');
  socket.on('data',function(data) {
    //client로부터 받아온 데이터를 출력
    console.log('rcv : '+data);
  });
  socket.on('close',function() {
    //접속이 끊길때 메세지 출력
    console.log('client disconnected');
  });
  socket.write('welcome to server');
  cron.schedule('*/10 * * * * *',function() {
  presentTime().then(()=>{
        console.log('presnetTime = ',cur_date,cur_time);
        socket.write(cur_date+'///'+cur_time);
    });
  }).start();
  //접속시 메세지 출력
});

server.on('error',function(err) {
  //에러시 메세지 출력
  console.log('err'+err);
});

server.listen(3000,function() {
  //접속 가능할때까지 대기
  console.log('linsteing on 3000..');
});


//https://ourcstory.tistory.com/67
