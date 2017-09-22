//
//  Package.swift
//  CalculationFinancial
//
//  Created by Duong Van Chung on 9/20/17.
//  Copyright © 2017 Duong Van Chung. All rights reserved.
//

import Foundation

extension Model {

	class Package {

		var moneyInvest: Double
		var currentStep: Int = 0
		var totalStep: Int = 0

		init(money: Double, totalStep: Int) {
			moneyInvest = money
			self.totalStep = totalStep
		}
	}
}

protocol BasePackage {

	var moneyInvest: Double { get }
	var currentStep: Int { get set }
	var totalStep: Int { get }
	var profitRate: Double { get }

	init(money: Double)
}

extension Model {

	struct ChainGroup {

		enum InvestmentLevel {
			case one, two, three, four

			static func level(withMoney money: Double) -> InvestmentLevel {
				switch money {
				case 0 ... 1000: return .one
				case 1010 ... 5000: return .two
				case 5010 ... 10000: return .three
				case 10010 ... Double.greatestFiniteMagnitude: return .four
				default: return .one
				}
			}

			func profitRate() -> Double {
				let baseProfitRate = Constant.Bitconnect.baseProfitRate
				switch self {
				case .one: return baseProfitRate
				case .two: return baseProfitRate + 0.001
				case .three: return baseProfitRate + 0.002
				case .four: return baseProfitRate + 0.0025
				}
			}

			func totalDayBack() -> Int {
				switch self {
				case .one: return 299
				case .two: return 239
				case .three: return 179
				case .four: return 120
				}
			}
		}

		class Package: BasePackage {

			var moneyInvest: Double
			var currentStep: Int = 0
			var investmentLevel: InvestmentLevel {
				return InvestmentLevel.level(withMoney: moneyInvest)
			}
			var totalStep: Int {
				return investmentLevel.totalDayBack()
			}
			var profitRate: Double {
				return investmentLevel.profitRate()
			}

			required init(money: Double) {
				moneyInvest = money
			}
		}
	}
}
