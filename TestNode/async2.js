
async function A() {
  return new Promise((resolve,reject)=> {

      var a = 3;
      a+=2;

    resolve(a);
  });
}



var c;
A().then(function (resolvedData) {
  c = resolvedData;
});

console.log(c);
