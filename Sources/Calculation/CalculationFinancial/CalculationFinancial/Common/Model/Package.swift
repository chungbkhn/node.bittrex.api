//
//  Package.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import Foundation

extension Model {

	class Package {

		var moneyInvest: Double
		var currentStep: Int = 0
		var totalStep: Int = 0

		init(money: Double, totalStep: Int) {
			moneyInvest = money
			self.totalStep = totalStep
		}
	}
}
