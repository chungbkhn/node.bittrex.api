//
//  BitconnectInvestment.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class BitconnectInvestment: Investment {
    var startMoneyInvest: Double = 0
    var profitRate: Double = 0
    var totalStep: Int = 0
	var totalStepPackage: Int = 0
	var invitationRate: Double = 0
    
    let refundCapitalBack: Bool = Constant.Bitconnect.refundCapitalBack
    let minMoneyReinvest: Double = Constant.Bitconnect.minMoneyReinvest
    let stepMoneyReinvest: Double? = Constant.Bitconnect.stepMoneyReinvest
    
    required init() {}
}
