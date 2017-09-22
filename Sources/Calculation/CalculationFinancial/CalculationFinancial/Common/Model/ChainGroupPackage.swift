//
//  ChainGroup.swift
//  CalculationFinancial
//
//  Created by David on 9/23/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import Foundation

extension Model {

	struct ChainGroup {

		class DailyPackage: BasePackage {

			var moneyInvest: Double = 0
			var currentStep: Int = 0
			let totalStep: Int = Constant.ChainGroup.Daily.totalDayPackage
			let profitRate: Double = Constant.ChainGroup.Daily.profitRate
			let refundCapitalBack: Bool = Constant.ChainGroup.refundCapitalBack
			let invitationRate: Double = Constant.ChainGroup.invitationRate

			required init(money: Double) {
				moneyInvest = money
			}
		}

		class MonthlyPackage: BasePackage {

			var moneyInvest: Double = 0
			var currentStep: Int = 0
			let totalStep: Int = Constant.ChainGroup.Monthly.totalDayPackage
			let profitRate: Double = Constant.ChainGroup.Monthly.profitRate
			let refundCapitalBack: Bool = Constant.ChainGroup.refundCapitalBack
			let invitationRate: Double = Constant.ChainGroup.invitationRate

			required init(money: Double) {
				moneyInvest = money
			}
		}
	}
}
