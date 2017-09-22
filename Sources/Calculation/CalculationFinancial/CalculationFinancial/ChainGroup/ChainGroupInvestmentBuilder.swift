//
//  ChainGroupInvestmentBuilder.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class ChainGroupInvestmentBuilder: Builder<ChainGroupInvestment> {

	func makeInvestment(money: Double, numberOfDays: Int) {
        object.startMoneyInvest = money
        object.totalStep = numberOfDays
    }
}
