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
        
        static let minMoneyReinvest = 10.0
        static let refundCapitalBack = false
        static let stepMoneyReinvest: Double? = nil
        
        struct Daily {
            static let profitRate = 0.028  // 2.8%/day
            static let totalDay = 180
        }
        
        struct Monthly {
            static let profitRate = 0.85  // 2.8%/day
            static let totalMonth = 6
        }
    }
}
