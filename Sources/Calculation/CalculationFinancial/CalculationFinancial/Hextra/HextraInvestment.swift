//
//  HextraInvestment.swift
//  CalculationFinancial
//
//  Created by David on 10/22/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class HextraInvestment: Investment {

	typealias T = Model.Hextra.Package

	var startMoneyInvest: Double = 0
	var totalStep: Int = 0

	let minMoneyReinvest: Double = Constant.Hextra.minMoneyReinvest
	let stepMoneyReinvest: Double? = Constant.Hextra.stepMoneyReinvest

	required init() {}
}
