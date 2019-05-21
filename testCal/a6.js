var moment=require('moment');

console.log( new Date( '2019', '05', 0).getDate());
var a = [1,2,3,4,5];
var c = a.slice(1,4);



console.log(c);
function test() {
  var b = [];
  // b.push(arguments[0]);
  // b.push(arguments[1]);
  // b.push(arguments[2]);
  b = arguments.slice(0,3);
  console.log(b);
}

test('1','2','3');
test('4','5','6');
