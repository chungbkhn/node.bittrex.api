var bittrex = require('../node.bittrex.api.js');

bittrex.options({
  'apikey' : 'e2a1d089907149df8cd28eee054d804b',
  'apisecret' : '4e948c7b56ae4b5290988e38183df5b1', 
  'stream' : false, // will be removed from future versions
  'verbose' : false,
  'baseUrl' : 'https://bittrex.com/api/v1.1',
  'cleartext' : false 
});

bittrex.getLastestCandles({
  marketName: 'USDT-BTC',
  tickInterval: 'thirtyMin', // intervals are keywords
}, function( data, err ) {
  console.log( data );
});