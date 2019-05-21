// function 정리
// 알고리즘 안정화
// 지속적인 결과 받기
// 04_13
// spaceData
var net = require('net');
const cron = require('node-cron');
const request = require('request');
var express = require('express');

var list = "hello";
var http = express();

http.get('/', function (req, res) {
  res.send(list);
});

http.listen(5000, function() {
  console.log('Start Server:3000');
});
