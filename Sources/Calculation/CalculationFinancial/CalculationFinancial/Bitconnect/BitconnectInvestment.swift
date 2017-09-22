//
//  BitconnectInvestment.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class BitconnectInvestment: Investment {
    var startMoneyInvest: Double = 0
    var totalStep: Int = 0
	var totalStepPackage: Int = 0
	var invitationRate: Double = 0
    
    let refundCapitalBack: Bool = Constant.Bitconnect.refundCapitalBack
    let minMoneyReinvest: Double = Constant.Bitconnect.minMoneyReinvest
    let stepMoneyReinvest: Double? = Constant.Bitconnect.stepMoneyReinvest
	let profitRate: Double = 0
    
    required init() {}

	private static let profitPerDayBase = Double(0.0093)
	private static let profitPerDayTable: [Double] = [profitPerDayBase, profitPerDayBase + 0.001, profitPerDayBase + 0.002, profitPerDayBase + 0.0025]
	func profitRate(for money: Double) -> Double {
		let profitPerDayTable = BitconnectInvestment.profitPerDayTable
		if money < 1010 {
			return profitPerDayTable[0]
		} else if money < 5010 {
			return profitPerDayTable[1]
		} else if money < 10010 {
			return profitPerDayTable[2]
		}

		return profitPerDayTable[3]
	}
}
