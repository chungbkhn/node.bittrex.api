

'use strict';

const mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'Bittrex',
    multipleStatements: true
});

var startConnection = function () {
    connection.connect();
}

var endConnection = function() {
    connection.end();
}

var sma = function(range, columnName, tableName, callback) {
    let sql = `SELECT ${columnName} FROM ${tableName} ORDER BY timestamp desc limit ${range}`;
    connection.query(sql, (error, result) => {
        if (error) {
            callback(error, 0);
            return;
        }

        if (result.length != range) {
            callback(null, 0);
        } else {
            let total = 0;
            for (var i = 0; i < result.length; i++) {
                let value = result[i][columnName];
                if (value == 0) {
                    total = 0;
                    break;
                } else {
                    total += value;
                }
            }
            let sma = total / range;

            callback(null, sma);
        }
    });
}

var smaClose = function (range, tableName, callback) {
    sma(range, "close", tableName, callback);
}

var smaVolume = function (range, tableName, callback) {
    sma(range, "volume", tableName, callback);
}

var saveData = function(data, smaRange, tableName, callback) {
    let date = new Date(data.T);
    isExistTimestamp(date, tableName, (error, isExist) => {
        if (error) {
            callback(error);
            return;
        }

        if (isExist) {
            updateData(data, tableName, callback);
        } else {
            insertData(data, smaRange, tableName, callback);
        }
    });
}

var isExistTimestamp = function(timestamp, tableName, callback) {
    let sql = `SELECT * FROM ${tableName} WHERE timestamp = ?`;

    connection.query(sql, timestamp, (error, result) => {
        if (error) {
            callback(error, false);
            return;
        }
        callback(null, result.length > 0);
    })
}

var insertData = function (data, smaRange, tableName, callback) {
    smaClose(smaRange, tableName, (err, smaValue) => {
        if (err) {
            callback(err);
            return;
        }

        let smaClose = smaValue;
        smaVolume(smaRange, tableName, (err, smaValue) => {
            if (err) {
                callback(err);
                return;
            }

            let smaVolume = smaValue;

            let sql = `INSERT INTO ${tableName} set ?`;

            connection.query(sql, {
                open: data.O,
                close: data.C,
                high: data.H,
                low: data.L,
                volume: data.BV,
                timestamp: new Date(data.T),
                unknow: data.V,
                smaClose: smaClose,
                smaVolume: smaVolume,
                updatedAt: new Date()
            }, (err) => {
                if (err) console.error(err);
                callback(err);
            });
        });
    });
}

var updateData = function(data, tableName, callback) {
    let sql = `UPDATE ${tableName} SET open = ?, close = ?, high = ?, low = ?, volume = ?, unknow = ?, updatedAt = ? WHERE timestamp = ?`;
    let baseTime = new Date(data.T);
    let currentTime = new Date();

    connection.query(sql, [data.O, data.C, data.H, data.L, data.BV, data.V, currentTime, baseTime], (error, result) => {
        if (error) {
            callback(error);
            return;
        }

        callback(null);
    });
}

var insertMultipleRow = function (datas, smaRange, tableName, callback) {
    let sql = `INSERT INTO ${tableName} 
    (open, close, high, low, volume, unknow, timestamp, smaClose, smaVolume, updatedAt) VALUES ?`;

    let params = Array();
    let totalClose = 0;
    let totalVolume = 0;

    for (let i = 0; i < datas.length; i++) {
        let data = datas[i];
        let currentTime = new Date();

        totalClose += data.C;
        totalVolume += data.BV;

        let smaClose = 0;
        let smaVolume = 0;

        if (i >= smaRange) {
            totalClose -= datas[i - smaRange].C;
            totalVolume -= datas[i - smaRange].BV;

            smaClose = totalClose / smaRange;
            smaVolume = totalVolume / smaRange;
        }

        let itemInputs = [data.O, data.C, data.H, data.L, data.BV, data.V, new Date(data.T), smaClose, smaVolume, currentTime];
        params.push(itemInputs);
    }

    connection.query(sql, [params], (error, result) => {
        if (error) {
            callback(error);
            return;
        }

        console.info(result);
        callback(null);
    });
}

var createTables = function (martkets, callback) {
   let sql = '';

   for (var i = 0; i< martkets.length; i++) {
       sql += sqlCreateTable(martkets[i].marketName.replace('-', ''));
   }

   // console.info(sql);
   connection.query(sql, (err, result) => {
       // console.info(result);
       callback(err);
   })
}

var sqlCreateTable = function (tableName) {
    return `CREATE TABLE IF NOT EXISTS ${tableName} (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  open float NOT NULL DEFAULT 0,
  close float NOT NULL DEFAULT 0,
  high float NOT NULL DEFAULT 0,
  low float NOT NULL DEFAULT 0,
  volume float NOT NULL DEFAULT 0,
  unknow float NOT NULL DEFAULT 0,
  smaClose float NOT NULL DEFAULT 0,
  smaVolume float NOT NULL DEFAULT 0,
  updatedAt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
`
}

var createMarketTable = function (callback) {
    let sql = `CREATE TABLE IF NOT EXISTS Market (
                  id int(11) unsigned NOT NULL AUTO_INCREMENT,
                  marketCurrency text NOT NULL,
                  baseCurrency text NOT NULL,
                  marketCurrencyLong text NOT NULL,
                  baseCurrencyLong text NOT NULL,
                  marketName text NOT NULL,
                  isActive tinyint(1) NOT NULL,
                  created timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                  PRIMARY KEY (id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
                `
    connection.query(sql, (err, result) => {
        callback(err);
    });
}

var insertMarketData = function (markets, callback) {
    let sql = `INSERT INTO Market 
    (marketCurrency, baseCurrency, marketCurrencyLong, baseCurrencyLong, marketName, isActive, created) VALUES ?`;

    let params = Array();

    for (let i = 0; i < markets.length; i++) {
        let data = markets[i];

        let itemInputs = [data.MarketCurrency, data.BaseCurrency, data.MarketCurrencyLong, data.BaseCurrencyLong, data.MarketName, data.IsActive, new Date(data.Created)];
        params.push(itemInputs);
    }

    connection.query(sql, [params], (error, result) => {
        callback(error);
    });
}

var getAllMarkets = function (callback) {
    let sql = `SELECT * FROM Market`;

    connection.query(sql, (error, result) => {
        callback(error, result);
    });
}

module.exports = {
    startConnection: startConnection,
    endConnection: endConnection,
    saveData: saveData,
    insertMultipleRow: insertMultipleRow,
    createTables: createTables,
    createMarketTable: createMarketTable,
    insertMarketData: insertMarketData,
    getAllMarkets: getAllMarkets
}


