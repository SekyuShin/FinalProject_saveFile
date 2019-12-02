var http = require('http');
var fs = require('fs');
var url = require('url');  // url 요구

function templateHTML(title, list, body) { //재사용할수 있는 껍대기 : template
  return `
  <!doctype html>
  <html>
  <head>
    <title>WEB1 - ${title}</title>
    <meta charset="utf-8">
  </head>
  <body>
    <h1><a href="/">WEB</a></h1>

      ${list}
      ${body}
  </body>
  </html>
  `;
}
function templateList(filelist) {
  var list = `<ul>`;
  var i = 0;
  while(i<filelist.length) {
      list = list + `<li><a href="/?id=${filelist[i]}">${filelist[i]}</a></li>`
      i = i+1;
    }
    list = list+`</ul>`;
    return list;
}

var app = http.createServer(function(request,response){ //노드 js의 서버 만들기
    var _url = request.url; //답변된 url을 저장
    var queryData = url.parse(_url, true).query; // _url 쿼리문에서 가져온 데이터 저장
    var pathname = url.parse(_url, true).pathname; // _url 위치 정보 저장

    if(pathname === '/'){
      if(queryData.id === undefined){
        fs.readdir('./data',function(err,filelist){

          var title = 'Welcome';
          var description = 'Hello, Node.js';
          var list = templateList(filelist);
          var template = templateHTML(title, list,`<h2>${description}`);
          response.writeHead(200);
          response.end(template);
        });


      } else {
        fs.readdir('./data',function(err,filelist){
        fs.readFile(`data/${queryData.id}`, 'utf8', function(err, description){
          var title = queryData.id;
          var list = templateList(filelist);
          var template = templateHTML(title, list,`<h2>${description}`);
          response.writeHead(200);
          response.end(template);
        });
      });
      }
    } else {
      response.writeHead(404);
      response.end('Not found');
    }
});
app.listen(3000);
