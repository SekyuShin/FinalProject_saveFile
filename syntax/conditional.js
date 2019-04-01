var args = process.argv;
//노드 실행시 추가적인 파라미터 가져오는 소스

console.log(args[2]);
console.log('A');
console.log('B');
if(args[2]==='1') {
  console.log('c1');
}else {
  console.log('c2');
}
console.log('D');
