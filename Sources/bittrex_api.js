const bittrex = require('../node.bittrex.api.js');
bittrex.options({
    'apikey': 'e2a1d089907149df8cd28eee054d804b',
    'apisecret': '4e948c7b56ae4b5290988e38183df5b1',
    'stream': false, // will be removed from future versions
    'verbose': false,
    'baseUrl': 'https://bittrex.com/api/v1.1',
    'cleartext': false
});

const db = require('./dbhelper');
db.startConnection();

/*
    * Interval is fixed.
    * List Value available: oneMin, fiveMin, thirtyMin, hour, day,
*/
var interval = 'thirtyMin';
var range = 10;
var timeIntervalRequestInfo = 2000; // 5 second
var markets = Array();

function initDataForMarket(index) {
    let market = markets[index];
    let marketName = market.marketName;
    console.info('Init data for market: ' + marketName + ' ...');
    bittrex.getcandles({
        marketName: marketName,
        tickInterval: interval, // intervals are keywords
    }, function (data, err) {
        if (err || !data.result) {
            console.error(err);
            return;
        }

        // console.info(data.result);

        let tableName = marketName.replace('-', '');
        db.insertMultipleRow(data.result, range, tableName, (err) => {
            if (index < markets.length - 1) {
                initDataForMarket(index + 1);
            } else {
                console.info("Created Data for markets!");
                getLastestCandles(0);
            }
        });
    });
}

function initMarkets() {
    bittrex.getmarkets(function (data, err) {
        if (err || !data.result) {
            console.error(err);
            return;
        }

        // console.info(data.result);
        resultMarkets = data.result;
        var tempMarkets = Array();

        for (var i = 0; i < resultMarkets.length; i++) {
            let market = resultMarkets[i];
            if (market.IsActive && market.BaseCurrency == 'USDT') {
                tempMarkets.push(market);
            }
        }

        db.createMarketTable((err) => {
            if (!err) {
                db.insertMarketData(tempMarkets, (error) => {
                    db.getAllMarkets((err, result) => {
                        markets = result;

                        db.createTables(markets, (err) => {
                            console.info("Created markets successfully!");

                            initDataForMarket(0);
                        });
                    });
                });
            }
        });
    });
}

function getLastestCandles(index) {
    let market = markets[index];
    let marketName = market.marketName;
    console.info('Updating Data for market: ' + marketName + ' ...');
    bittrex.getLastestCandles({
        marketName: marketName,
        tickInterval: interval // intervals are keywords
    }, function (data, err) {
        if (err) {
            console.error(err);
            getLastestCandles(index);
            return;
        }

        // console.info(data.result);
        item = data.result[0];

        if (item) {
            let tableName = marketName.replace('-', '');
            db.saveData(item, range, tableName, (err) => {
                if (err) {
                    console.error(err);
                } else {
                    console.info("Updated data for market: " + marketName + "!");
                }

                setTimeout(() => {
                    if (index < markets.length - 1) {
                        getLastestCandles(index + 1);
                    } else {
                        getLastestCandles(0);
                    }
                }, timeIntervalRequestInfo);
            });
        } else {
            getLastestCandles(index);
        }
    });
}

function waitToNextTime(func) {
    setTimeout(() => {
        func();
    }, timeIntervalRequestInfo);
}

function startUpdateLastestData() {
    db.getAllMarkets((err, result) => {
        markets = result;

        getLastestCandles(0);
    });
}

// initMarkets();
startUpdateLastestData();