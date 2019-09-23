
var net = require('net');
var cron = require('node-cron');
var request = require('request');
var express = require('express');
var moment=require('moment');
var fs = require('fs');





var server = net.createServer(function(socket) {
  //서버를 생성
  console.log(socket.address().address+'connected');
  console.log(`${moment().format("YYYY-MM-DD HH:mm:ss")}`)
  // socket.connect(function(){
  //   console.log('connect');
  // });
  socket.on('data',function(data) {
    //client로부터 받아온 데이터를 출력
    console.log(`${moment().format("YYYY-MM-DD HH:mm:ss")}`);
    console.log('rcv : '+data);

    socket.write("data rcv ok : "+data+"\n");
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
