const cron = require('node-cron');
var now = new Date();
const hh = ("00" + now.getHours()).slice(-2);
const mm = ("00" + now.getMinutes()).slice(-2);
var cur_time = hh + '30';
console.log(cur_time);

if(cur_time.slice(-2)<45) {
  cur_time=(cur_time.slice(0,2)-1)+'45';
} else {
  cur_time = cur_time.slice(0,2)+'45';
}

console.log(cur_time);

function show(now) {
  console.log(now);
}
function scheduler(data) {
cron.schedule(data, function () {
    //now = new Date();
      var now = new Date();
    show(now);
    //console.log(`${date_str}: `,year,month,day,hour,minutes);
}).start();
}

scheduler('1,2,5,8,9,30,50 * * * * *');
