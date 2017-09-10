var MySQLAPI = function() {
    'use strict';

	var mysql = require('mysql');
	var isStartedConnection = false;

    var con = mysql.createConnection({
      host: "localhost",
      user: "root",
      password: "",
      database: "Bittrex"
    });

    var startConnect = function(callback) {
        con.connect(function(err) {
          if (err) {
            console.error('error connecting: ' + err.stack);
            callback(isStartedConnection);
            return;
          }
         
          console.log('connected as id ' + con.threadId);

          isStartedConnection = true;

          callback(isStartedConnection);
        });
    }

    var stopConnect = function(callback) {
        connection.end(function(err) {
            if (err) {
                console.error('error connecting: ' + err.stack);
                return;
            }

            callback(true);
        });
    }

    var dbAPICall = function(sql, callback) {
      con.query(sql, function (err, result) {
        if (err) throw err;

        callback(result, err);
      });
    };

    return {
        getAllCandles30Min: function(callback) {
            var sql = 'select * from Candle30Min';
            dbAPICall(sql, callback);
        },
        insertCandles30Min: function(open, close, high, low, volume, timestamp, callback) {
            var sql = 'insert into Candle30Min (open, close, high, low, volume) values (' + open + ', ' + close + ', ' + high + ', ' + low + ', ' + volume + ')';
            dbAPICall(sql, callback);
        },
        startConnect: function (callback) {
            startConnect(callback);
        },
        stopConnect: function (callback) {
            stopConnect(callback);
        }
    };
}();

module.exports = MySQLAPI;