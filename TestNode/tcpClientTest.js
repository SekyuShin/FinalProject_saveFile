var net = require('net');

var socket = net.connect({port:5000});
socket.on('connect',function() {
  console.log('connected to server');
setInterval(function() {
  var i=0;
  i=i+1;
  socket.write('banana hong : ' + i);
},1000);

});

socket.on('data',function(chunk) {
  console.log('recv : ' + chunk);
});

socket.on('end',function() {

  console.log('disconnected');
});

socket.on('error',function(err) {
  console.log(err);
});

socket.on('timeout',function() {
  console.log('connection timeout');
});
