var moment = require('moment');
var net = require('net');
var test = [];
function structMem(start,end,id,str) {
  this.start = start;
  this.end = end;
  this.id = id;
  this.str = str;
}

function add_12() {

}

var str = '1_2_3_4_5_6_7_8_9_10_11_12';

str.split('_')

console.log(moment().format('YYYY-MM-DDTHH:mm:SS+09:00'));
console.log(moment().add(12,'hours').format('YYYY-MM-DDTHH:mm:SS+09:00'));
//console.log(meoment());

test.push(new structMem('1','2','stst','haha'));
test.push(new structMem('2','3','stst2','haha2'));

console.log(test[1].id);
console.log(test.length);
