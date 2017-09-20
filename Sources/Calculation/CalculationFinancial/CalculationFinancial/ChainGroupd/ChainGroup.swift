//
//  ChainGroup.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

class ChainGroup: NSObject {

    var profitPerDay = 0.028    // 2.8%/day
    var totalDay = 180    // 180 days
    var profitPerMonth = 0.85   // 85%/month
    var totalMonth = 6.0      // Fix 6 month
    var moneyInvested = 200.0 // In USD
    
    var stepMoneyInvest = Double(10)   // min = 10$
    var minMoneyReinvest = Double(10)
    
    /// Round Money to 3 decimals. Example: money = 0.026 -> result = 0.03
    ///
    /// - Parameter money: money in Double
    /// - Returns: Money after round to 3 decimals
    fileprivate func roundMoney(money: Double) -> Double {
        return Double(round(money * 100) / 100)
    }
    
    fileprivate func devideMoneyReInvest(money: Double) -> (nextInvestMoney: Double, remain: Double) {
        let stepInvest = Double(Int(money / stepMoneyInvest))
        
        var moneyInvest = stepInvest * stepMoneyInvest
        
        if moneyInvest < minMoneyReinvest { moneyInvest = 0 }
        let remain = money - moneyInvest
        return (moneyInvest, remain)
    }
}

// MARK: - Daily

extension ChainGroup {
    
    func getMoneyAllDay() -> Double {
        return moneyInvested * profitPerDay * Double(totalDay)
    }
    
    func moneyDaily(numberOfDay: Int) -> (packageInvest: [Double], remain: Double) {
        if numberOfDay == 0 {
            return ([moneyInvested], 0)
        }
        
        let moneyPreviousDay = moneyDaily(numberOfDay: numberOfDay - 1)
        
        var profit = Double(0)
        
        for invest in moneyPreviousDay.packageInvest {
            profit += roundMoney(money: invest * profitPerDay)
        }
        
        profit += moneyPreviousDay.remain
        
        let moneyNextInvest = devideMoneyReInvest(money: profit)
        
        var newPackageInvest = moneyPreviousDay.packageInvest
        if moneyNextInvest.nextInvestMoney > 0 {
            newPackageInvest.append(moneyNextInvest.nextInvestMoney)
        }
        
        return (newPackageInvest, moneyNextInvest.remain)
    }
    
    func getMoneyForDay(dayInvest: Int) -> Double {
        let newMoney = moneyDaily(numberOfDay: dayInvest).packageInvest.reduce(0, +)
        let remainDay = totalDay - dayInvest
        
        return newMoney * Double(remainDay) * profitPerDay
    }
}

// MARK - Monthly

extension ChainGroup {
    
    /// Plan1: get profit all month
    ///
    /// - Returns: money after all month
    func getMoneyAllMonth() -> Double {
        return moneyInvested * profitPerMonth * totalMonth
    }
    
    func increaseMoneyMonthlyInvest(monthReInvest: Int) -> Double {
        return moneyInvested * pow(profitPerMonth + 1, Double(monthReInvest))
    }
    
    func getMoneyForMonth(monthReInvest: Int) -> Double {
        let newMoney = increaseMoneyMonthlyInvest(monthReInvest: monthReInvest)
        let remainMonth = totalMonth - Double(monthReInvest)
        
        return newMoney * profitPerMonth * remainMonth
    }
}
