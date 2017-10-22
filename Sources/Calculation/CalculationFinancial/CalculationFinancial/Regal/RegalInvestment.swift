//
//  RegalInvestment.swift
//  CalculationFinancial
//
//  Created by David on 10/22/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class RegalInvestment: Investment {

	typealias T = Model.Regal.Package

	var startMoneyInvest: Double = 0
	var totalStep: Int = 0

	let minMoneyReinvest: Double = Constant.Regal.minMoneyReinvest
	let stepMoneyReinvest: Double? = Constant.Regal.stepMoneyReinvest

	required init() {}
}
