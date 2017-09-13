const bittrex = require('../node.bittrex.api.js');
bittrex.options({
    'apikey': 'e2a1d089907149df8cd28eee054d804b',
    'apisecret': '4e948c7b56ae4b5290988e38183df5b1',
    'stream': false, // will be removed from future versions
    'verbose': false,
    'baseUrl': 'https://bittrex.com/api/v1.1',
    'cleartext': false
});

const db = require('dbhelper.js');
db.startConnection();

var interval = 'thirtyMin';
var range = 10;

function getLastestCandles() {
    bittrex.getLastestCandles({
        marketName: 'USDT-BTC',
        tickInterval: interval, // intervals are keywords
    }, function (data, err) {
        if (err) {
            console.error(err);
            return;
        }

        if (data) {
            items = data.result

            if (items.length > 0) {
                db.smaClose(range, (sma) => {
                    if (!sma) {
                        waitToNextTime(getLastestCandles);
                        return;
                    }

                    let item = result[0];
                    db.saveData(item, sma,(error) => {
                        waitToNextTime(getLastestCandles);
                    });
                });
            } else {
                waitToNextTime(getLastestCandles);
            }
        }
    });
}

function waitToNextTime(func) {
    setTimeout(() => {
        func();
    }, 5000);
}

getLastestCandles();
