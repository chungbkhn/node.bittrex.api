

'use strict';

const mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'Bittrex'
});

var startConnection = function () {
    connection.connect();
}

var endConnection = function() {
    connection.end();
}

var smaClose = function(range, callback) {
    let sql = `SELECT AVG(t.CLOSE) avg FROM Candle30min t ORDER BY t.timestamp desc limit ?`;
    connection.query(sql, range, (error, result) => {
        if (error) {
            callback(null);
            return;
        }

        let sma = result[0]['avg'];
        callback(sma);
    });
}

var saveData = function(data, sma, callback) {
    let sql = `INSERT INTO Candle30Min set ?`;

    connection.query(sql, {
        open: data[0].O,
        close: data[0].C,
        high: data[0].H,
        low: data[0].L,
        volume: data[0].V,
        timestamp: new Date(data[0].T),
        bv: data[0].BV,
        sma: sma
    }, (err) => {
        if (err) console.error(err);
        console.info("Success");
        callback(err);
    });
}

var isExistTimestamp = function(timestamp, callback) {
    let sql = `SELECT * FROM Candle30min WHERE timestamp == ?`;

    connection.query(sql, timestamp, (error, result) => {
        if (error) {
            callback(null);
            return;
        }

        callback(result.length > 0);
    })
}

module.exports = {
    startConnection: startConnection,
    endConnection: endConnection,
    smaClose: smaClose,
    saveData: saveData,
    isExistTimestamp: isExistTimestamp
}


