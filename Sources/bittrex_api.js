const bittrex = require('../node.bittrex.api.js');



bittrex.options({
    'apikey': 'e2a1d089907149df8cd28eee054d804b',
    'apisecret': '4e948c7b56ae4b5290988e38183df5b1',
    'stream': false, // will be removed from future versions
    'verbose': false,
    'baseUrl': 'https://bittrex.com/api/v1.1',
    'cleartext': false
});


// var mySql = require('./db.js');
//   mySql.startConnect( function (result) {
//     if (result) {

//         mySql.insertCandles30Min(10, 20, 30, 40, 232454, function (data, err) {
//             console.log('Insert: ' + data);
//         });
//     }
//     }
// );
//
// mySql.getAllCandles30Min(function( data, err ) {
//   console.log( 'Data: ' + data );
// });


function fun() {
    bittrex.getLastestCandles({
        marketName: 'USDT-BTC',
        tickInterval: 'thirtyMin', // intervals are keywords
    }, function (data, err) {


        if (err) {
            console.error(err);
            return;
        }

        if (data) {
            var mysql = require('mysql');
            var connection = mysql.createConnection({
                host: 'localhost',
                user: 'root',
                password: '',
                database: 'Bittrex'
            });

            connection.connect();

            data = data.result


            let sql = `INSERT INTO Candle30Min set ?`;

            connection.query(`SELECT AVG(t.CLOSE) avg FROM Candle30min t ORDER BY t.timestamp desc limit 2`, (error, result, field) => {
                if (error) return;
                let ema = result[0]['avg'];
                connection.query(sql, {
                    open: data[0].O,
                    close: data[0].C,
                    high: data[0].H,
                    low: data[0].L,
                    volume: data[0].V,
                    timestamp: new Date(data[0].T),
                    bv: data[0].BV,
                    ema: ema
                }, (err) => {
                    if (err) console.error(err);
                    console.info("Success")

                    connection.end();

                    setTimeout(() => {
                        fun();
                    }, 5000);

                });
            });


            // connection.end();
        }


    });
}

fun();
