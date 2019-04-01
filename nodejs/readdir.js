var testFolder = '../data';
var fs = require('fs');

fs.readdir(testFolder,function(err,filelist) {
  console.log(filelist);
});

//디렉토리 안에있는 파일 목록 가져오기
