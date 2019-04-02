var http = require('http');
var fs = require('fs');
var url = require('url');  // url 요구

// node-schedule 모듈 사용
var cron = require('node-cron');
cron.schedule('50 */2 * * * *', function () {
    console.log('1info', 'running a task every minute / ' + new Date());
}).start();
cron.schedule('2,5,8,11 * * * * *', function () {
    console.log('2info', 'running a task every minute / ' + new Date());
}).start();
