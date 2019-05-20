const oneTwoThree = [1, 2, 3];
let result = oneTwoThree.map((v) => {
  console.log(v);
  return v;
});
function presentTime() {
  return new Promise((resolve, reject) => {
    const d = new Date();
    console.log(d);
    const YYYY = d.getFullYear();
    const MM = ("00" + (d.getMonth() + 1)).slice(-2);
    const DD = ("00" + d.getDate()).slice(-2);
    var cur_date = YYYY+MM+DD;
    const hh = ("00" + d.getHours()).slice(-2);
    const mm = ("00" + d.getMinutes()).slice(-2);
    var cur_time = hh+mm;

    resolve(cur_date+cur_time);
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
presentTime().then(function(now) {
  console.log(rfc3339(now));
})
console.log();
