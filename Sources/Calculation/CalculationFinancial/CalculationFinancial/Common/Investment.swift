//
//  Investment.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import Foundation

protocol Investment: Initializable {

	associatedtype T: BasePackage

    var startMoneyInvest: Double { get }
    var totalStep: Int { get }

    var minMoneyReinvest: Double { get }
    var stepMoneyReinvest: Double? { get }      // set to nil if platform don't require step money reinvest
}

extension Investment {

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

	func moneyInfo(after step: Int) -> (packageInvests: [T], remain: Double, invitationEarned: Double) {
        if step == 0 {
			let newInvest = T(money: startMoneyInvest)
			return ([newInvest], 0, newInvest.invitationMoney)
        }

        let moneyPreviousDay = moneyInfo(after: step - 1)

        var profit = Double(0)

        var newPackageInvests: [T] = []
        for package in moneyPreviousDay.packageInvests {
//			print("Money: \(package.moneyInvest)  profitRate: \(package.profitRate)  ProfitMoney: \(package.profitMoneyPerStep)")
            profit += package.profitMoneyPerStep
            package.currentStep += 1

            if package.currentStep < package.totalStep {
                newPackageInvests.append(package)
            } else {
                if package.refundCapitalBack {
                    profit += package.moneyInvest
                }
            }
        }

        profit += moneyPreviousDay.remain

        let moneyNextInvest = devideMoneyReInvest(money: profit)

		var newInvitationEarned = moneyPreviousDay.invitationEarned
        if moneyNextInvest.nextInvestMoney > 0 {
			let newInvestment = T(money: moneyNextInvest.nextInvestMoney)
			newPackageInvests.append(newInvestment)
			newInvitationEarned += newInvestment.invitationMoney
        }

        return (newPackageInvests, moneyNextInvest.remain, newInvitationEarned)
    }

	func moneyEarned(reinvestIn step: Int) -> (total: Double, invitation: Double) {
        let money = moneyInfo(after: step)
        let remainStep = totalStep - step

		var total: Double = 0

		for package in money.packageInvests {
			let numberOfSteps = min(remainStep, package.totalStep - package.currentStep)
			total += package.profitMoneyPerStep * Double(numberOfSteps)
			if package.refundCapitalBack {
				total += package.moneyInvest
			}
		}

		total += money.remain
		total += money.invitationEarned

		return (total, money.invitationEarned)
    }
}
