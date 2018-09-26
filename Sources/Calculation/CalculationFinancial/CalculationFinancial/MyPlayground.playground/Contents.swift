//: Playground - noun: a place where people can play

import Foundation

struct PairTrading {	// ExtraCoin/BaseCoin

	let extraCode: String
	let baseCode: String

	let buyPrice: Double
	let sellPrice: Double
}

extension PairTrading {

	func getExtraCoin(baseCoin: Double) -> Double {
		let extraCoin = baseCoin * (1 - feeTransaction) / sellPrice
		print("Get \(extraCoin) \(extraCode)")
		return extraCoin
	}

	func getBaseCoin(extraCoin: Double) -> Double {
		let baseCoin = extraCoin * buyPrice * (1 - feeTransaction)
		print("get \(baseCoin) \(baseCode)")
		return baseCoin
	}
}

let feeTransaction = 0.0015 	// 0.15% - CoinExchange

/*
// Example XP_BTC, XP_DOGE, DOGE_BTC
// BaseCoin = BTC
// ExtraCoin = XP
// TempBaseCoin = DOGE
*/
struct TransactionPair {
	let u: PairTrading
	let v: PairTrading
	let t: PairTrading

	/// XP_BTC -> XP_DOGE -> DOGE_BTC
	func profit(baseCoin: Double) -> Double {
		print("Profit: XP_BTC -> XP_DOGE -> DOGE_BTC")
		print("Base BTC: \(baseCoin)")
		let extraCoin = u.getExtraCoin(baseCoin: baseCoin)
		let tempBaseCoin = v.getBaseCoin(extraCoin: extraCoin)
		let newBaseCoin = t.getBaseCoin(extraCoin: tempBaseCoin)
		let profitAfterTrading = (newBaseCoin / baseCoin) - 1
		print("===============\n")
		return profitAfterTrading * 100
	}

	/// DOGE_BTC -> XP_DOGE -> XP_BTC
	func profitWay2(baseCoin: Double) -> Double {
		print("Profit: DOGE_BTC -> XP_DOGE -> XP_BTC")
		print("Base BTC: \(baseCoin)")
		let tempBaseCoin = t.getExtraCoin(baseCoin: baseCoin)
		let extraCoin = v.getExtraCoin(baseCoin: tempBaseCoin)
		let newBaseCoin = u.getBaseCoin(extraCoin: extraCoin)
		let profitAfterTrading = (newBaseCoin / baseCoin) - 1
		print("===============\n")
		return profitAfterTrading * 100
	}

	/// DOGE_BTC -> LTC_DOGE -> LTC_BTC
	func profitWay3(baseCoin: Double) -> Double {
		print("Profit: DOGE_BTC -> LTC_DOGE -> LTC_BTC")
		print("Base BTC: \(baseCoin)")
		let extraCoin = u.getExtraCoin(baseCoin: baseCoin)
		let tempBaseCoin = v.getExtraCoin(baseCoin: extraCoin)
		let newBaseCoin = t.getBaseCoin(extraCoin: tempBaseCoin)
		let profitAfterTrading = (newBaseCoin / baseCoin) - 1
		print("===============\n")
		return profitAfterTrading * 100
	}
}

func earnBy_XP_DOGE_BTC() -> (profit: Double, profitWay2: Double) {
	let moon_btc = PairTrading(extraCode: "XP", baseCode: "BTC", buyPrice: 0.00000001, sellPrice: 0.00000002)
	let moon_doge = PairTrading(extraCode: "XP", baseCode: "DOGE", buyPrice: 0.01980000, sellPrice: 0.02091000)
	let doge_btc = PairTrading(extraCode: "DOGE", baseCode: "BTC", buyPrice: 0.00000060, sellPrice: 0.00000061)

	let transactionPair = TransactionPair(u: moon_btc, v: moon_doge, t: doge_btc)
	let profit = transactionPair.profit(baseCoin: 0.32)
	let profitWay2 = transactionPair.profitWay2(baseCoin: 0.32)
	return (profit, profitWay2)
}

func earnBy_DOGE_LTC_BTC() -> (profit: Double, profitWay2: Double) {
	let doge_btc = PairTrading(extraCode: "DOGE", baseCode: "BTC", buyPrice: 0.00000060, sellPrice: 0.00000061)
	let ltc_doge = PairTrading(extraCode: "LTC", baseCode: "DOGE", buyPrice: 27010.00500010, sellPrice: 28449.00000000)
	let ltc_btc = PairTrading(extraCode: "LTC", baseCode: "BTC", buyPrice: 0.01665008, sellPrice: 0.01672000)

	let transactionPair = TransactionPair(u: doge_btc, v: ltc_doge, t: ltc_btc)
	let profit = transactionPair.profit(baseCoin: 0.32)
	let profitWay3 = transactionPair.profitWay3(baseCoin: 0.32)
	return (profit, profitWay3)
}

let trade = earnBy_XP_DOGE_BTC()
print("Profit: \(trade.profit)")
print("ProfitWay2: \(trade.profitWay2)")


//protocol PairTradingProtocol {	// ExtraCoin/BaseCoin
//
//	var extraCode: String { get }
//	var baseCode: String { get }
//
//	var buyPrice: Double { get }
//	var sellPrice: Double { get }
//}
//
//extension PairTradingProtocol {
//
//	func getExtraCoin(baseCoin: Double) -> Double {
//		let extraCoin = baseCoin * (1 - feeTransaction) / sellPrice
//		print("Get \(extraCoin) \(extraCode)")
//		return extraCoin
//	}
//
//	func getBaseCoin(extraCoin: Double) -> Double {
//		let baseCoin = extraCoin * buyPrice * (1 - feeTransaction)
//		print("get \(baseCoin) \(baseCode)")
//		return baseCoin
//	}
//}
//
//struct XP_BTC: PairTradingProtocol {
//
//	let extraCode: String = "XP"
//	let baseCode: String = "BTC"
//
//	let buyPrice: Double
//	let sellPrice: Double
//}
//
//struct XP_DOGE: PairTradingProtocol {
//
//	let extraCode: String = "XP"
//	let baseCode: String = "DOGE"
//
//	let buyPrice: Double
//	let sellPrice: Double
//}
//
//struct DOGE_BTC: PairTradingProtocol {
//
//	let extraCode: String = "DOGE"
//	let baseCode: String = "BTC"
//
//	let buyPrice: Double
//	let sellPrice: Double
//}
//
//let feeTransaction = 0.0015 	// 0.15% - CoinExchange
//
///*
//	// Example XP_BTC, XP_DOGE, DOGE_BTC
//	// BaseCoin = BTC
//	// ExtraCoin = XP
//	// TempBaseCoin = DOGE
//*/
//class TransactionPair<U: PairTradingProtocol, V: PairTradingProtocol, T: PairTradingProtocol> {
//	let u: U
//	let v: V
//	let t: T
//
//	init(u: U, v: V, t: T) {
//		self.u = u
//		self.v = v
//		self.t = t
//	}
//
//
//	/// XP_BTC -> XP_DOGE -> DOGE_BTC
//	func profit(baseCoin: Double) -> Double {
//		print("Profit: XP_BTC -> XP_DOGE -> DOGE_BTC")
//		print("Base BTC: \(baseCoin)")
//		let extraCoin = u.getExtraCoin(baseCoin: baseCoin)
//		let tempBaseCoin = v.getBaseCoin(extraCoin: extraCoin)
//		let newBaseCoin = t.getBaseCoin(extraCoin: tempBaseCoin)
//		let profitAfterTrading = (newBaseCoin / baseCoin) - 1
//		print("===============\n")
//		return profitAfterTrading * 100
//	}
//
//	/// DOGE_BTC -> XP_DOGE -> XP_BTC
//	func profitWay2(baseCoin: Double) -> Double {
//		print("Profit: DOGE_BTC -> XP_DOGE -> XP_BTC")
//		print("Base BTC: \(baseCoin)")
//		let tempBaseCoin = t.getExtraCoin(baseCoin: baseCoin)
//		let extraCoin = v.getExtraCoin(baseCoin: tempBaseCoin)
//		let newBaseCoin = u.getBaseCoin(extraCoin: extraCoin)
//		let profitAfterTrading = (newBaseCoin / baseCoin) - 1
//		print("===============\n")
//		return profitAfterTrading * 100
//	}
//}
//
//let xp_btc = XP_BTC(buyPrice: 0.00000007, sellPrice: 0.00000008)
//let xp_doge = XP_DOGE(buyPrice: 0.12800000, sellPrice: 0.12999999)
//let doge_btc = DOGE_BTC(buyPrice: 0.00000060, sellPrice: 0.00000061)
//
//let transactionPair = TransactionPair<XP_BTC, XP_DOGE, DOGE_BTC>(u: xp_btc, v: xp_doge, t: doge_btc)
//let profit = transactionPair.profit(baseCoin: 0.32)
//let profitWay2 = transactionPair.profitWay2(baseCoin: 0.32)

