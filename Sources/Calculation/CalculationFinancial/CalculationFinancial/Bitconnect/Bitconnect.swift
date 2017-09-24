//
//  Bitconnect.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

//: Playground - noun: a place where people can play

import UIKit

class BitConnect {

    let profitPerDayTable: [Double] = [0.0093, 0.0103, 0.0113, 0.0118]

    var stepMoneyInvest = Double(10)   // min = 10$
    var startInvestMoney = Double(690)  // 690$
    var minMoneyReinvest = Double(10)

    /// Round Money to 3 decimals. Example: money = 0.026 -> result = 0.03
    ///
    /// - Parameter money: money in Double
    /// - Returns: Money after round to 3 decimals
    private func roundMoney(money: Double) -> Double {
        return Double(round(money * 100) / 100)
    }

    private func devideMoneyReInvest(money: Double) -> (nextInvestMoney: Double, remain: Double) {
        let stepInvest = Double(Int(money / stepMoneyInvest))

        var moneyInvest = stepInvest * stepMoneyInvest

        if moneyInvest < minMoneyReinvest { moneyInvest = 0 }
        let remain = money - moneyInvest
        return (moneyInvest, remain)
    }

    private func ratioProfit(for money: Double) -> Double {
        if money < 1010 {
            return profitPerDayTable[0]
        } else if money < 5010 {
            return profitPerDayTable[1]
        } else if money < 10010 {
            return profitPerDayTable[2]
        }

        return profitPerDayTable[3]
    }

    private func moneyReinvestAt(numberOfDay: Int) -> (packageLending: [Double], remain: Double) {
        if numberOfDay == 0 {
            return ([startInvestMoney], 0)
        }

        // When numberOfDay > 0
        let moneyPreviousDay = moneyReinvestAt(numberOfDay: numberOfDay - 1)

        var profit = Double(0)

        for lending in moneyPreviousDay.packageLending {
            profit += roundMoney(money: lending * ratioProfit(for: lending))
        }

        profit += moneyPreviousDay.remain

        let moneyNextInvest = devideMoneyReInvest(money: profit)

        var newPackageLending = moneyPreviousDay.packageLending
        if moneyNextInvest.nextInvestMoney > 0 {
            newPackageLending.append(moneyNextInvest.nextInvestMoney)
        }

        return (newPackageLending, moneyNextInvest.remain)
    }

    func moneyGainProfit(numberOfDay: Int) -> Double {
        return startInvestMoney * ratioProfit(for: startInvestMoney) * Double(numberOfDay)
    }

    func moneyEarned(numberOfDay: Int) -> (reinvest: Double, gain: Double) {
        let moneyInfo = moneyReinvestAt(numberOfDay: numberOfDay)
        let moneyReinvest = moneyInfo.packageLending.reduce(0, +) + moneyInfo.remain

        let moneyGain = moneyGainProfit(numberOfDay: numberOfDay)

        return (moneyReinvest, moneyGain)
    }
}

/*
let dayInvest = 180

let package1 = BitConnect()
package1.startInvestMoney = 690
let moneyGainPackage1 = package1.moneyGainProfit(numberOfDay: dayInvest)

let package2 = BitConnect()
package2.startInvestMoney = 1010
let moneyPackage2 = package2.moneyEarned(numberOfDay: dayInvest)

let package3 = BitConnect()
package3.startInvestMoney = 100
let moneyGainPackage3 = package3.moneyGainProfit(numberOfDay: dayInvest)

let moneyEarnAfter = moneyGainPackage1 + moneyPackage2.reinvest * 0.1 + moneyGainPackage3
let balance = moneyEarnAfter - package1.startInvestMoney - package2.startInvestMoney - package3.startInvestMoney
*/
