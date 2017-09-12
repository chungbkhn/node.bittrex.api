const mysql = require('mysql');

console.log(mysql);
exports.pool = mysql.createPool({

    host            : 'localhost',
    user            : 'root',
    password        : '',
    database        : 'Bittrex'
});
console.log(exports.pool);


exports.create = function() {

    console.log('init')
    if (!exports.pool) {
        console.log("create pool");

    }
}

exports.getConnection = exports.pool.getConnection