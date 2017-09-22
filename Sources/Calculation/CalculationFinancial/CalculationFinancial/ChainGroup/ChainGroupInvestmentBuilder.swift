//
//  ChainGroupInvestmentBuilder.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class ChainGroupInvestmentBuilder: Builder<ChainGroupInvestment> {

	func makeDailyInvestment(money: Double, numberOfDay: Int) {
        object.startMoneyInvest = money
        object.totalStep = numberOfDay
		object.totalStepPackage = Constant.ChainGroup.Daily.totalDayPackage
        object.profitRate = Constant.ChainGroup.Daily.profitRate
		object.invitationRate = Constant.ChainGroup.invitationRate
    }
    
	func makeMonthlyInvestment(money: Double, numberOfMonth: Int) {
        object.startMoneyInvest = money
        object.totalStep = numberOfMonth
		object.totalStepPackage = Constant.ChainGroup.Monthly.totalDayPackage
        object.profitRate = Constant.ChainGroup.Monthly.profitRate
		object.invitationRate = Constant.ChainGroup.invitationRate
    }
}
