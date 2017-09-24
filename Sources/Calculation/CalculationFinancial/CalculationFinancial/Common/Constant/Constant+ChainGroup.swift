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
		static let profitRate: Double = 0.028  // 2.8%/day
		static let totalDay: Int = 180
		static let totalDayPackage: Int = 180
		static let startInvestedMoney: Double = 500
    }
}
