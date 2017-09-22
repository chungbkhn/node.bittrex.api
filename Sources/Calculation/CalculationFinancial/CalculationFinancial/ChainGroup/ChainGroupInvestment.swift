//
//  ChainGroupInvestment.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class ChainGroupInvestment: Investment {

    var startMoneyInvest: Double = 0
    var profitRate: Double = 0
	var totalStepPackage: Int = 0
    var totalStep: Int = 0

    let invitationRate: Double = Constant.ChainGroup.invitationRate
    let refundCapitalBack: Bool = Constant.ChainGroup.refundCapitalBack
    let minMoneyReinvest: Double = Constant.ChainGroup.minMoneyReinvest
    let stepMoneyReinvest: Double? = Constant.ChainGroup.stepMoneyReinvest
    
    required init() {}
}
