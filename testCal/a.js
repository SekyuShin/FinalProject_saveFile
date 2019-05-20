
var cur_time;
var cur_date;
function test(base) {
  var result = base+arguments[1]; //arguments 는 그냥 파라미터
  return result;
}
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
    cur_time = hh+mm;

    resolve();
  });
}
function rfc3339(time) {
  const YYYY = time.slice(0,5);

  const MM = time.slice(5,7);
  const DD = time.slice(7,9);
  cur_date = YYYY+MM+DD;
  const hh = time.slice(9,11);
  const mm = time.slice(11,13);
  cur_time = hh+mm;
  return cur_date+cur_time;
}
function test1(callback) {
  if(callback === test) {
    console.log('test start');
    console.log(callback(7,5));
  }else {
    console.log('what');
  }
}
test1(test);

presentTime();
console.log(rfc3339('199208100909'));
