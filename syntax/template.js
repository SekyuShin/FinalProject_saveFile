var name = 'egoing';
var letter1 = 'Dear'+name+'\
\djfkldjlfkdlj'+name+'llslslslllslslls'+'hahahahahahahahah';
console.log(letter1); //가능하다. but 코드상에서만 줄바꿈이 된다.

var letter2 = 'Dear'+name+'\n\n djfkldjlfkdlj'+name+'llslslslllslslls'+'hahahahahahahahah';
console.log(letter2);



//template literal `` 작은 따음표가 아니다. 그레이브 엑센트
// literal 정보를 표현하는 기호
var letter3 = `Dear ${name}
    djfkldjlfkdlj ${1+1} llslslslllslslls hahahahahahahahah`;
console.log(letter3);
