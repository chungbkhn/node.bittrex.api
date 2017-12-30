//
//  Exchange.swift
//  CalculationFinancial
//
//  Created by David on 11/18/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import Foundation

import SwiftyJSON

protocol MarketProtocol {

	var coinInfoes: [Exchange.Key: Exchange.CoinInfo] { get }
	var transferFees: [Exchange.Key: Double] { get }
	var transactionFee: Double { get }
}

extension MarketProtocol {

	func transferFee(forKey key: Exchange.Key) -> Double {
		if let fee = transferFees[key] {
			return fee
		} else {
			return 0
		}
	}

	func parseCoinInfoes(jsonString: String) -> [Exchange.Key: Exchange.CoinInfo]? {
		let json = JSON.init(parseJSON: jsonString)
		var result: [Exchange.Key: Exchange.CoinInfo] = [:]

		assert(false)
		return result
	}
}

struct Exchange {

	enum Key: String {
		case btcUSD = "BTC-USD"
		case dashUSD = "DASH-USD"
		case ltcUSD = "LTC-USD"
		case bccUSD = "BCC-USD"
		case bccBTC = "BCC-BTC"
	}

	struct CoinInfo {

		struct PriceInfo: Codable {
			let price: Double
			let volume: Double
		}

		let askPrices: [PriceInfo]
		let bidPrices: [PriceInfo]
	}
}

extension Exchange {

	static func invest(quantity: Double, key: Key, middleKey: Key, sourceMarket: MarketProtocol, destinationMarket: MarketProtocol, convertCoinInSourceMarket: Double) -> (profit: Double, profitPercent: Double) {
		let quantityInDestinationMarket = quantity - sourceMarket.transferFee(forKey: key)

		let moneyInDestinationMarket = getMoney(coin: quantityInDestinationMarket, prices: destinationMarket.coinInfoes[key]!.bidPrices, transactionFee: destinationMarket.transactionFee)

		let middleCoinInDestinationMarket = getCoin(money: moneyInDestinationMarket, prices: destinationMarket.coinInfoes[middleKey]!.askPrices, transactionFee: destinationMarket.transactionFee)

		let middleCoinInSourceMarket = middleCoinInDestinationMarket - destinationMarket.transferFee(forKey: middleKey)

		let coinInSourceMarket = middleCoinInSourceMarket / convertCoinInSourceMarket * sourceMarket.transactionFee

		return (coinInSourceMarket, (coinInSourceMarket - quantity) / quantity)
	}

	static func getMoney(coin: Double, prices: [CoinInfo.PriceInfo], transactionFee: Double) -> Double {
		var totalCoin: Double = 0
		var totalMoney: Double = 0
		for priceInfo in prices {
			if totalCoin >= coin {
				break
			}

			if totalCoin + priceInfo.volume >= coin {
				let quantityCanBuy = coin - totalCoin
				totalMoney += quantityCanBuy * priceInfo.price * (1 - transactionFee)
				break
			}

			totalCoin += priceInfo.volume
			totalMoney += priceInfo.price * priceInfo.volume * (1 - transactionFee)
		}

		if coin > totalCoin {
			assert(false, "Can't sell all coin in Destination market")
		}

		return totalMoney
	}

	static func getCoin(money: Double, prices: [CoinInfo.PriceInfo], transactionFee: Double) -> Double {
		var totalCoin: Double = 0
		var totalMoney: Double = 0
		for priceInfo in prices {
			if totalMoney >= money {
				break
			}

			if totalMoney + priceInfo.price * priceInfo.volume >= money {
				let moneyCanBuy = money - totalMoney
				totalCoin += moneyCanBuy / priceInfo.price * (1 - transactionFee)
				break
			}

			totalMoney += priceInfo.price * priceInfo.volume
			totalCoin += priceInfo.volume * (1 - transactionFee)
		}

		if money > totalMoney {
			assert(false, "Can't buy all middlecoin in Destination market")
		}

		return totalCoin
	}
}
