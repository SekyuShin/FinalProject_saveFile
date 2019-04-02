var async = require('async');

var tasks = [
    function (callback) {
        setTimeout(function () {
            console.log('one');
            callback(null, 'one-1', 'one-2');
        }, 200);
    },
    function (callback) {
        setTimeout(function () {
            console.log('two');
            callback(null, 'two');
        }, 100);
    }
];

async.series(tasks, function (err, results) {
    console.log(results);
    // [ ['one-1', 'one-2'], 'two' ]
});
