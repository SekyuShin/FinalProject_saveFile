var moment=require('moment');
var now = moment().format('YYYY-MM-DDTHH:MM:SS+09:00');
var start = moment('199208100909','YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00');
console.log(now);
console.log(start);
