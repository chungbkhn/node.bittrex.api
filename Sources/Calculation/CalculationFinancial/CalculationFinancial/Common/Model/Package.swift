//
//  Package.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import Foundation

protocol BasePackage: class {

	var moneyInvest: Double { get set }
	var currentStep: Int { get set }
	var totalStep: Int { get }
	var profitRate: Double { get }
	var refundCapitalBack: Bool { get }
	var invitationRate: Double { get }

	init(money: Double)
}

extension BasePackage {

	var invitationMoney: Double {
		return invitationRate * moneyInvest
	}

	var profitMoneyPerStep: Double {
		return Util.roundMoneyProfit(money: moneyInvest * profitRate)
	}
}
