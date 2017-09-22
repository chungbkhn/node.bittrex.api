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
}
