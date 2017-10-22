//
//  Builder.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import Foundation

protocol Initializable: class {
    init()
}

class Builder<T: Investment> {

    let object = T()

    func outputObject() -> T {
        return object
    }

	func makeInvestment(money: Double, numberOfDays: Int) {
		object.startMoneyInvest = money
		object.totalStep = numberOfDays
	}
}
