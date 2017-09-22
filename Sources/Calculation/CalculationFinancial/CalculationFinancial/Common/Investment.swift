//
//  Investment.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import Foundation

protocol Investment: Initializable {

	associatedtype T: Model.Package
    
    var startMoneyInvest: Double { get }
    var profitRate: Double { get }
	var totalStepPackage: Int { get }
    var totalStep: Int { get }
    var refundCapitalBack: Bool { get }
	var invitationRate: Double { get }
    
    var minMoneyReinvest: Double { get }
    var stepMoneyReinvest: Double? { get }      // set to nil if platform don't require step money reinvest
    
    func profitRate(for money: Double) -> Double
}

extension Investment {
    
    func profitRate(for money: Double) -> Double {
        return profitRate
    }
    
    private func roundMoneyProfit(profit: Double) -> Double {
        return Double(round(profit * 100) / 100)
    }
    
    private func profitPerStep(money: Double) -> Double {
        return roundMoneyProfit(profit: profitRate(for: money) * money)
    }
    
    private func devideMoneyReInvest(money: Double) -> (nextInvestMoney: Double, remain: Double) {
        var moneyInvest = Double(0)
        if let `stepMoneyReinvest` = stepMoneyReinvest {
            let stepInvest = Double(Int(money / stepMoneyReinvest))
            
            moneyInvest = stepInvest * stepMoneyReinvest
        } else {
            moneyInvest = money
        }
        
        if moneyInvest < minMoneyReinvest { moneyInvest = 0 }
        let remain = money - moneyInvest
        return (moneyInvest, remain)
    }
    
	func moneyInfo(after step: Int) -> (packageInvests: [Model.Package], remain: Double, invitationEarned: Double) {
        if step == 0 {
			return ([Model.Package(money: startMoneyInvest, totalStep: totalStepPackage)], 0, startMoneyInvest * invitationRate)
        }
        
        let moneyPreviousDay = moneyInfo(after: step - 1)
        
        var profit = Double(0)
        
        var newPackageInvests: [Model.Package] = []
        for package in moneyPreviousDay.packageInvests {
            profit += profitPerStep(money: package.moneyInvest)
            package.currentStep += 1
            
            if package.currentStep < package.totalStep {
                newPackageInvests.append(package)
            } else {
                if refundCapitalBack {
                    profit += package.moneyInvest
                }
            }
        }
        
        profit += moneyPreviousDay.remain
        
        let moneyNextInvest = devideMoneyReInvest(money: profit)

		var newInvitationEarned = moneyPreviousDay.invitationEarned
        if moneyNextInvest.nextInvestMoney > 0 {
			newPackageInvests.append(Model.Package(money: moneyNextInvest.nextInvestMoney, totalStep: totalStepPackage))
			newInvitationEarned += moneyNextInvest.nextInvestMoney * invitationRate
        }
        
        return (newPackageInvests, moneyNextInvest.remain, newInvitationEarned)
    }
    
    func moneyEarned(reinvestIn step: Int) -> Double {
        let money = moneyInfo(after: step)
        let remainStep = totalStep - step

		var total: Double = 0

		for package in money.packageInvests {
			let numberOfSteps = min(remainStep, package.totalStep - package.currentStep)
			total += profitPerStep(money: package.moneyInvest) * Double(numberOfSteps)
		}

		total += money.remain
		total += money.invitationEarned

		return total
    }
}
