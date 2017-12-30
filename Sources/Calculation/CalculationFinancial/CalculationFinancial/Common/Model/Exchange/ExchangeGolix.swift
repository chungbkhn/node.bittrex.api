//
//  ExchangeGolix.swift
//  CalculationFinancial
//
//  Created by David on 11/18/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

extension Exchange {

	struct Golix: MarketProtocol {

		var coinInfoes: [Exchange.Key: Exchange.CoinInfo] = [:]
		var transferFees: [Exchange.Key: Double] = [.btcUSD: 0.001, .dashUSD: 0.001, .ltcUSD: 0.001, .bccUSD: 0.001]
		var transactionFee: Double = 0.02 // 2%

		init() {
			var askPrices = [CoinInfo.PriceInfo]()
			var priceInfo = CoinInfo.PriceInfo(price: 14990, volume: 0.1604)
			askPrices.append(priceInfo)

			var bidPrices = [CoinInfo.PriceInfo]()
			priceInfo = CoinInfo.PriceInfo(price: 14300, volume: 0.03)
			bidPrices.append(priceInfo)

			var coinInfo = CoinInfo(askPrices: askPrices, bidPrices: bidPrices)

			self.coinInfoes[.btcUSD] = coinInfo
		}
	}
}
