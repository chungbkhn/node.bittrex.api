//
//  ChainGroupInvestmentBuilder.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class ChainGroupInvestmentBuilder: Builder<ChainGroupInvestment> {

    func makeDailyInvestment(money: Double) {
        object.startMoneyInvest = money
        object.totalStep = Constant.ChainGroup.Daily.totalDay
        object.profitRate = Constant.ChainGroup.Daily.profitRate
    }
    
    func makeMonthlyInvestment(money: Double) {
        object.startMoneyInvest = money
        object.totalStep = Constant.ChainGroup.Monthly.totalMonth
        object.profitRate = Constant.ChainGroup.Monthly.profitRate
    }
}
