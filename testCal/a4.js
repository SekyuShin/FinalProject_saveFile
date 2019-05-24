var str = 'Android_insert_go to movie with friends_201905231100_201905231300';
var con = str.split('_');

console.log(con);
console.log(str);


if(con[1]=='insert') {
  console.log('yes insert');
} else if(con[1] == 'delete') {
  console.log('yes delete');
}

var list='';

list+='_hello';
console.log(list);
list +='-wow';
console.log(list);

function work(){
	// 5초 이상 걸리는 작업
	for(var i=0; i < 5000000000; i++);
	console.log('work완료');
}

function test(callback) {
  callback();
  console.log('test end');
}
test(work);
setTimeout(function() {
  console.log(1000);
},1000);
