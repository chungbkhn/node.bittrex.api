//: Playground - noun: a place where people can play

import UIKit

enum ExchangeKey: String {
    case btcUSD = "BTC-USD"
    case dashUSD = "DASH-USD"
    case ltcUSD = "LTC-USD"
    case bccUSD = "BCC-USD"
    case bccBTC = "BCC-BTC"
}

protocol ExchangeProtocol {
    
    /// BTC-USD, DASH-USD, LTC-USD, BCC-USD
    var coinPrices: [String: Double] { get }
    var transactionFee: Double { get }
}

struct Exchange {
    
    struct Bittrex: ExchangeProtocol {
        
        let coinPrices: [String: Double] = [ExchangeKey.btcUSD.rawValue: 7800,
                                            ExchangeKey.dashUSD.rawValue: 410,
                                            ExchangeKey.ltcUSD.rawValue: 66.6,
                                            ExchangeKey.bccUSD.rawValue: 1000,
                                            ExchangeKey.bccBTC.rawValue: 0.03]
        let transactionFee: Double = 0.0025 // 0.25%
    }
    
    struct Golix: ExchangeProtocol {
        
        let coinPrices: [String: Double] = [ExchangeKey.btcUSD.rawValue: 15000,
                                            ExchangeKey.dashUSD.rawValue: 700,
                                            ExchangeKey.ltcUSD.rawValue: 120,
                                            ExchangeKey.bccUSD.rawValue: 1000,
                                            ExchangeKey.bccBTC.rawValue: 0.03]
        let transactionFee: Double = 0.02 // 2%
    }
    
    static let transferFee: Double = 0.001
}
//
//func trade(inputExchange: ExchangeProtocol, outputExchange: ExchangeProtocol, mainCoin: String, extraCoin: String) -> Double {
//    let btcInGolix = btcInBittrex - Exchange.transferFee
//    let usdInGolix = btcInGolix * Exchange.Golix.btcUSD * (1 - Exchange.Golix.transactionFee)
//    let ltcInGolix = usdInGolix / Exchange.Golix.ltcUSD * (1 - Exchange.Golix.transactionFee)
//    let ltcInBittrex = ltcInGolix - Exchange.transferFee
//    let resultUSDInBittrex = ltcInBittrex * Exchange.Bittrex.ltcUSD * (1 - Exchange.Bittrex.transactionFee)
//    let resultBTCInBittrex = resultUSDInBittrex / Exchange.Bittrex.btcUSD * (1 - Exchange.Bittrex.transactionFee)
//    
//    return resultBTCInBittrex
//}
//
//let x = trade(btcInBittrex: 0.2)

