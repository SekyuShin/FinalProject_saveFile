function test() {
  return new Promise(function(resolve,reject){
    for(var i=0; i < 1000000000; i++);
    console.log('test end');
    test1().then(function (data) {
      if(data == 1) {
        resolve('complete');
      } else {
        reject('fail');
      }
    });

  });
}
function test1() {
  return new Promise(function(resolve,reject){
  for(var i=0; i < 5000000000; i++);
  console.log('test1 end');
  test2().then(function (data) {
    if(data == 1) {
      resolve(1);
    } else {
      reject(0);
    }
  });
});
}
function test2() {
  return new Promise(function(resolve,reject){
  for(var i=0; i < 2000000000; i++);
  console.log('test2 end');
  test3().then(function (data) {
    if(data == 1) {
      resolve(1);
    } else {
      reject(0);
    }
  });
});
}
function test3() {
  return new Promise(function(resolve,reject){
    try {
      for(var i=0; i < 1000000000; i++);
      console.log('test3 end');
      resolve(1);
    } catch (err) {
      reject(err);
    }
  });
}


test().then(function(data) {
  console.log(data);
});
