
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
  var rfc_format='';
  rfc_format += time.slice(0,4);
  rfc_format += '-';
  rfc_format +=time.slice(4,6);
  rfc_format += '-';
  rfc_format += time.slice(6,8);
  rfc_format += 'T';
  rfc_format += time.slice(8,10);
  rfc_format += ':';
  rfc_format += time.slice(10,12);
  rfc_format += ':00+09:00';

  return rfc_format;
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


console.log(rfc3339('201905201550'));
