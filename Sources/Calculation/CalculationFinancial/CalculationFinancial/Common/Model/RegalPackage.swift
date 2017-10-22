//
//  RegalPackage.swift
//  CalculationFinancial
//
//  Created by David on 10/22/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

extension Model {

	struct Regal {

		class Package: BasePackage {

			var moneyInvest: Double = 0
			var currentStep: Int = 0

			let totalStep: Int = Constant.Regal.totalDayPackage
			let profitRate: Double = Constant.Regal.profitRate
			let refundCapitalBack: Bool = Constant.Regal.refundCapitalBack
			let invitationRate: Double = Constant.Regal.invitationRate

			required init(money: Double) {
				moneyInvest = money
			}
		}
	}
}
