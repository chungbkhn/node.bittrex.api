//
//  ChainGroupInfo.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class ChainGroupInfo {
    
    private let chainGroup = ChainGroup()
    
    // Pre config
    init() {
        chainGroup.moneyInvested = 200
    }
    
    func runCalculation() {
        backgroundQueue.async { [weak self] _ in
            guard let `self` = self else { return }
            
            self.calculate()
        }
    }

    private func calculate() {
        print("Start calculate for chain group")
        
        var maxMoney = Double(0)
        var totalDayReInvest = 1
        
        for i in 1 ... (chainGroup.totalDay - 1) {
            let money = chainGroup.getMoneyForDay(dayInvest: i)
            if money > maxMoney {
                maxMoney = money
                totalDayReInvest = i
            }
        }
        
        print("Start Money: \(chainGroup.moneyInvested)\nNumber of Day reinvest: \(totalDayReInvest)\nMax money return: \(maxMoney)")
    }
}
