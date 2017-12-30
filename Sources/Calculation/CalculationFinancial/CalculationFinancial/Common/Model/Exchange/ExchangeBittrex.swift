//
//  ExchangeBittrex.swift
//  CalculationFinancial
//
//  Created by David on 11/18/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

import SwiftyJSON

extension Exchange {

	struct Bittrex: MarketProtocol {

		var coinInfoes: [Exchange.Key: Exchange.CoinInfo] = [:]
		var transferFees: [Exchange.Key: Double] = [.btcUSD: 0.001, .dashUSD: 0.001, .ltcUSD: 0.001, .bccUSD: 0.001]
		var transactionFee: Double = 0.0025 // 0.25%
	}
}
