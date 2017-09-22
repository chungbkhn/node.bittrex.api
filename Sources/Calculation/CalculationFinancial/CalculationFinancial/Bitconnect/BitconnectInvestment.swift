//
//  BitconnectInvestment.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class BitconnectInvestment: Investment {

	typealias T = Model.Bitconnect.Package

    var startMoneyInvest: Double = 0
    var totalStep: Int = 0

    let minMoneyReinvest: Double = Constant.Bitconnect.minMoneyReinvest
    let stepMoneyReinvest: Double? = Constant.Bitconnect.stepMoneyReinvest
    
    required init() {}
}
