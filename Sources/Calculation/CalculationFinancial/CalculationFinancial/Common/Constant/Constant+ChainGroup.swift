//
//  Constant+ChainGroup.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import Foundation

extension Constant {

    struct ChainGroup {

		static let minMoneyReinvest: Double = 10.0
        static let refundCapitalBack = false
        static let stepMoneyReinvest: Double? = nil
		static let invitationRate: Double = 0.05	// 5%
		static let profitRate: Double = 0.022  // 2.2%/day
		static let totalDay: Int = 180
		static let totalDayPackage: Int = 180
		static let startInvestedMoney: Double = 500
    }
}

extension Constant.ChainGroup {

	struct XBot {

		static let minMoneyReinvest: Double = 250
		static let refundCapitalBack = false
		static let stepMoneyReinvest: Double? = nil
		static let invitationRate: Double = 0.05	// 5%
		static let profitRate: Double = 0.03  // 3%/day
		static let totalDay: Int = 90
		static let totalDayPackage: Int = 90
		static let startInvestedMoney: Double = 2500
	}
}
