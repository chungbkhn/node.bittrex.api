//
//  Util.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import UIKit

struct Util {

	static func roundMoneyProfit(money: Double) -> Double {
		return Double(round(money * 100) / 100)
	}

	static func date(after numberOfDays: Int, referenceDate: Date) -> Date {
		return Calendar.current.date(byAdding: .day, value: numberOfDays, to: referenceDate)!
	}
}
